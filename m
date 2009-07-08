From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Tue, 07 Jul 2009 22:39:34 -0700
Message-ID: <4A543116.8050507@gmail.com>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 07:39:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOPsg-0005ve-FJ
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 07:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbZGHFjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 01:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbZGHFji
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 01:39:38 -0400
Received: from mail-pz0-f193.google.com ([209.85.222.193]:38285 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbZGHFji (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 01:39:38 -0400
Received: by pzk31 with SMTP id 31so3414864pzk.33
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 22:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=9H2ZUCQPfSWpKejxrjvRN99VhVh4smWPgfE2CQ1F2/M=;
        b=oxfHLXQnnOE5XQWGBL+Ar3GJ+cNkAPNviyNNC6J+PTqplHBzA+6iqYQkIG0gjaGR0H
         kNwWkiiaDux8LuSDA6RnobLnsf+1njAf/NdfxX8cSKFd4zi0z3425gbxjUKIEMXInaWU
         TMhRVFgvAxCnm8TodFUUehyiwHayacKHhO9tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=xB4/B9AkRufgSvxJ/c8UHaan7jOLgzeitaDyTdlelklPdFZsqkpyllE8lW8HxMs/GC
         2un8xBNRVtsluOXvmYiFoWShVugtstheBaORn0DIWy1g6S6SNwwqo68hGmx8zWiVGtvl
         8uCzHuRqaJH80aHo3Dw/NVeHvT+S+MY+QdCaQ=
Received: by 10.114.92.20 with SMTP id p20mr10944597wab.90.1247031577614;
        Tue, 07 Jul 2009 22:39:37 -0700 (PDT)
Received: from ?10.10.0.5? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id g25sm793579wag.8.2009.07.07.22.39.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Jul 2009 22:39:36 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090629)
In-Reply-To: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122891>

Junio C Hamano wrote:
> For the following three series, I have not managed to convince myself if
> these changes have real-world needs.
>
> * sb/read-tree (Thu Jun 25 22:14:10 2009 -0700) 2 commits
>  - read-tree: migrate to parse-options
>  - read-tree: convert unhelpful usage()'s to helpful die()'s

I think the first patch is good. I am still thinking about the second
one though. Obviously rc is coming so it's not too pressing.

I've done a quick survey of parse-optification of builtins and I see
that send-pack, rev-list, and fetch-pack all set bitfields when parsing
options. Migrating these will have the same problems. I don't know if
there's really any simple answer to it though, because you can't take
the address of a bitfield. And I think it's stupid to make the bitfields
into full ints just to support parse-options.

Maybe some builtins are just never meant to be migrated. Like
update-index and its --cacheinfo option.
