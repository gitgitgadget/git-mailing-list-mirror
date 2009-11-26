From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 19:16:55 -0500
Message-ID: <4B0DC8F7.1000509@gmail.com>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <20091125203922.GA18487@coredump.intra.peff.net> <7viqcytjic.fsf@alter.siamese.dyndns.org> <20091125210034.GC18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org> <20091125214949.GA31473@coredump.intra.peff.net> <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com> <60F92BD7-6FFF-4D9A-B2F0-0858F4E90B59@wincent.com> <7vd436p339.fsf@alter.siamese.dyndns.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 01:17:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDS2h-00087H-MP
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759973AbZKZAQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759658AbZKZAQw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:16:52 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:64630 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759605AbZKZAQv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:16:51 -0500
Received: by ywh12 with SMTP id 12so279002ywh.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Myim2LpQ/V84g1Fmedkfkq256KzhdV9xblT0ziqeZhs=;
        b=cSvlkza6+lOyz9v6MjHhf8rPKWqeigD5LeXBbAvC8yP3g+CrSqwLlABj0FzDLo85i8
         rltSrFNTVXsl7OVS/nsmyemJPemOM5rx6eu84Xw4NFKb0/8I4lRBq4gFRrRGRwgzUWYz
         KXzf/nc0oVdMK/hZlf3ZjZej2VK/aWmj1D1MM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=fUJQmPi0AQerNYnozVyf28L3bxfiJS9Wc1UedpPAwgVc4zHmJaUQus6vJA9TZIk3Rc
         +/0pOSvUF0yTp1ogxy+JmuEPNFuxxw8Aq3AmZMVLD7VQoMz0DYnck7UzQDqW9Z+L0ldm
         nEksRJe9/Ym70sxD2XIhgxfK8v4eD9bpJHT14=
Received: by 10.150.120.42 with SMTP id s42mr374064ybc.312.1259194617993;
        Wed, 25 Nov 2009 16:16:57 -0800 (PST)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 6sm66947ywd.52.2009.11.25.16.16.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:16:57 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7vd436p339.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133713>

Junio C Hamano wrote:

>  - git does not accept paths (it lets you specify patterns that match,
>    e.g. t/ to name ptahs under t/ directory).

Here is where it get interesting!

Our users, new and old alike, are wanting consistency. Consistency 
amongst the git commands. Consistency with their platform of choice. 
Consistency with what they are familiar with, Consistency with their 
expectations.

Declaring that git commands (all?!) do not take paths but patterns does 
not help the situation; however technically correct it may be.

>  - "/pathspec" does follow the widespread convention that a string that
>    begin with a "/" refer to a path rooted at the root _in the context_;
>    the definition of root may or may not match the filesystem root.

But the users are almost always dealing with things (objects) that 
started as files, act like files and may be files again. Why should they 
not expect filesystem semantics.
