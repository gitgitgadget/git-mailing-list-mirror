From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v4 9/9] Documentation: git stash branch now tolerates
 non-stash references.
Date: Sat, 14 Aug 2010 10:30:25 +1000
Message-ID: <AANLkTi=U5HaHvXMjum3zpZgBRD68gPN=vk7f8iy7Q-VM@mail.gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
	<1281398688-21008-10-git-send-email-jon.seymour@gmail.com>
	<7vr5i3mj4h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j6t@kdbg.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 02:30:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok4dr-0008NI-Ny
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 02:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334Ab0HNAa0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 20:30:26 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52656 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932316Ab0HNAaZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 20:30:25 -0400
Received: by qyk29 with SMTP id 29so221889qyk.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 17:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5Wc0pQ3J0ooSwK6r6BDGq9aQYtVp6MkdQlwyyFgfxTI=;
        b=YXXKi50H5XWpjxQRfBaLAemyhEtHfnWrv4PIwifWL1WJckeqhTUn06c1YaEZurHLDn
         IT6DkvlFl1klftnymu2qx9Fo2vm9SHvghh0TeLWe/a5bC7L+kUglpV2LuDfdAKRzcYWR
         x8kiodnlbmJeCe2Q77FFL24wEs18kone7x+nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TO6eSfnm9h9W0mwuwdvy89mfwFZgwcuZ86k0GfKQ1pc9q/0XjslTrYqiHYxeyCfW/k
         0BVMeF0GDAf+dMFH4zCQ+84IrAMXF2mCKtWOZZRA+QnmyPCmDCYysF640i6j84zlzVLS
         zQbrKyLapbX+SSTmCHBgQ4N6TLNTZ7ncFOiLg=
Received: by 10.229.1.163 with SMTP id 35mr1678259qcf.299.1281745825296; Fri,
 13 Aug 2010 17:30:25 -0700 (PDT)
Received: by 10.229.231.199 with HTTP; Fri, 13 Aug 2010 17:30:25 -0700 (PDT)
In-Reply-To: <7vr5i3mj4h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153536>

On Fri, Aug 13, 2010 at 10:49 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
> Hmm.
>
> Is there anything that describes how <stash-like>, <stash-entry> and
> <stash> relate to each other? =C2=A0I do not think a regular reader c=
an answer
> by reading the description after the patch these questions:
>
> =C2=A0- Is a <stash-entry> a <stash-like>?
> =C2=A0- Is the opposite true?
>
> etc...
>
> Perhaps we can simply call these two-parent merge commits a <stash>,
> define that these commands as working on a <stash>, add notes to cert=
ain
> subcommands that the <stash> they take must be on the stash ref (as
> opposed to a freestanding one you can create with "stash create"), an=
d be
> done with it?
>
> Also what is the error condition? =C2=A0I am assuming that your <stas=
h-entry>
> is a <stash-like> that is on the reflog of refs/stash, but if you giv=
e a
> <stash-like> that is not a <stash-entry> (iow a freestanding <stash>)=
 to a
> subcommand that wants to see <stash-entry>, what happens, and does th=
e
> document describe it as an error?
>
>> -pop [--index] [-q|--quiet] [<stash>]::
>> +pop [--index] [-q|--quiet] [<stash-entry>]::
>>
>> =C2=A0 =C2=A0 =C2=A0 Remove a single stashed state from the stash li=
st and apply it
>> =C2=A0 =C2=A0 =C2=A0 on top of the current working tree state, i.e.,=
 do the inverse
>

Ok, I'll have another crack at it, and address the other issues you
have noted in another round.

Thanks for the review.

jon.
