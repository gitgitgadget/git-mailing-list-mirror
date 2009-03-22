From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2 1/3] format-patch: create patch filename in one function
Date: Sat, 21 Mar 2009 22:59:24 -0700
Message-ID: <49C5D3BC.3030100@gmail.com>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com> <1237696363-6819-2-git-send-email-bebarino@gmail.com> <7vwsai86nw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 07:01:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlGk0-0001R8-HR
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 07:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbZCVF7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 01:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbZCVF7b
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 01:59:31 -0400
Received: from mail-gx0-f208.google.com ([209.85.217.208]:39806 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbZCVF7a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 01:59:30 -0400
Received: by gxk4 with SMTP id 4so4529140gxk.13
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 22:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=0hoytXSOh74u8qCO9cTx6zRfTwz0T60wTou5L5b8Ckw=;
        b=VJJ4TVEsvThJRs5krRjo4kvhvLNlGXOixIx7fwfrNVqbqACqjDC7fYY6LC10eMbipA
         mmGy7+VMegnu16kmPbNhXWNN9MjPFk9+jepsMU24DWR7A2L/VYp2uFf4Na5xx81H4jdR
         rN9cuXb7r0EV9Oo4vmN0Xfbml5njxrd7+HmJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=jzT4YeSr9h7SvnzV+Zi9k8U7eEUx5DE51QL6NqMMWHp900mgdJC9PpfWX6Y3G5Tlv3
         uFdZ03Y0ZGzBNUlGbjkovDfhfErq17CHMvLS6ahJEtciq9q+x40I7AtPDJiw+wEl0jai
         ZSLprCq7d4fnJqX+8ljYfYdMaB+H0ZeJWR77g=
Received: by 10.142.210.8 with SMTP id i8mr2247201wfg.297.1237701567237;
        Sat, 21 Mar 2009 22:59:27 -0700 (PDT)
Received: from ?192.168.1.3? ([76.89.212.195])
        by mx.google.com with ESMTPS id 20sm8360671wfi.52.2009.03.21.22.59.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Mar 2009 22:59:26 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (X11/20090102)
In-Reply-To: <7vwsai86nw.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114121>

Junio C Hamano wrote:
> The renaming is a good idea even without any change in the feature.
> Naming functions after what their result is used _for_ is never a good
> idea, and we should name them after what they do.
>
> Does it still make sense to pass "keep_subject" to the function?  After
> all what it does is to retain "[PATCH.." prefix that is useless for the
> purpose of making each patch easily identifiable.  Because people almost
> always use patch acceptance tools in non-keep mode to strip the
> "[PATCH..]"  prefix when creating the commits these days anyway, it may
> make more sense to lose the parameter altogether and simplify the
> processing.

I originally removed "keep_subject" but I took it out because I couldn't
figure out what it was being used for and I thought it might be
important. When it's removed all the tests pass. It's not even used by
other code besides a few if cases regarding numbering logic so I think
the entire command line switch could be removed.

>
> I also wonder if it makes sense to move what this function does into a
> user format; especially the logic that sanitizes the oneline string into
> filename friendly one may be something Porcelains may want an access to
> from outside.
>
> IOW, you can introduce a new format specifier (say, "%f") to
> format_commit_message() and the implemention of get_patch_filename() would
> just prepare a strbuf and call format_commit_message() on it, no?

This sounds great! I'm new so I don't know where to look for something
like this.
