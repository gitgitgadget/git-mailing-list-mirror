From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Sun, 24 Aug 2008 10:54:05 +0600
Message-ID: <7bfdc29a0808232154l3619fe0s3112620e4028e769@mail.gmail.com>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.1.10.0808232120420.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: git@vger.kernel.org, users@kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 06:55:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX7dB-0002dR-Cv
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 06:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbYHXEyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 00:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbYHXEyH
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 00:54:07 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:65141 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbYHXEyG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 00:54:06 -0400
Received: by yw-out-2324.google.com with SMTP id 9so92107ywe.1
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 21:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=z8r14wO4wzYL57OT+EtHuIr3Gs6O55ZWHJu0XW7dflY=;
        b=wel9rUMHgJO6FChOeQt3AxM3ThUj7yABxnEFqgU18/cBirVP2KxD/dWblhYO5/4ep6
         ZmEGFlcffwAOFQ6igoXauNPK561GMfEIkZHO/JuFyWSQwucoNr0AiHKM5YILp5KjIwYV
         q8BiJ7Zi8cUrQXO74qjHDMRDtDgZUALUBs0Ag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=RZnZTdz+VzztzapWlL7c1fL7lkVVig4vadRPrb18dpSxoATSifTFKsUlecS68akG7J
         yh8H3Ds5mNYpF3a+s3o+p51dPd7Ghi3tyhnsJGv2+zRQv4HU6c4gDafVL82DasbGc87G
         MjbxIhTgezG2hneeFWSJmK/4sIzfCF/gZ5hbM=
Received: by 10.150.212.14 with SMTP id k14mr545874ybg.89.1219553645647;
        Sat, 23 Aug 2008 21:54:05 -0700 (PDT)
Received: by 10.150.225.1 with HTTP; Sat, 23 Aug 2008 21:54:05 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0808232120420.3363@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93517>

On Sun, Aug 24, 2008 at 10:23 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Sat, 23 Aug 2008, Junio C Hamano wrote:
>>
>> There is one alternative, and one augmentation:
>>
>>  (A) We do not do anything.
>>
>>  (B) In addition to the main transition plan, outside git, prepare an
>>      optional "git-old-style" package that installs many "git-foo"
>>      wrappers in $PATH (i.e. /usr/bin).  Each of them exec "git foo".
>>      People who like the dashed form can keep typing "git-foo", even
>>      though that will cost them two exec()s.
>
> I actually suspect that (A) is fine.
>
> I suggested removing the "git-xyzzy" hardlinks entirely, but that was just
> because I didn't think anybody wanted them.
>
> But given that with the 1.6.0 model you can always just do
>
>        PATH="PATH:$(git --exec-path)"
>

If it is simple enough to get the git-abc commands by simply editing
the PATH var then I would have to agree that (A) is the option I would
prefer as well (not that I am as important as Linus though :)). I am
also using the git-abc formats in some of my scripts but I would
rather edit the PATH variable than to have then installed in /usr/bin
(Not to mention that I will be update to 'git abc' as soon as I have
time :)).

> in your .bashrc or similar to get the git-xyzzy form, and given that
> clearly some people like using them, there's really no downside to keeping
> them.
>
> I _would_ suggest against putting them in /usr/bin, even as a
> "compatibility plan". Just expose them to people who want them, who can
> really quite easily do the above PATH setting.
>
>                Linus
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Best regards

-- 
Imran M Yousuf
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
