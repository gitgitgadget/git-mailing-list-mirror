From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Wed, 3 Feb 2010 14:54:04 -0500
Message-ID: <32541b131002031154o2146aa05k1065f7bb2d4139dc@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com> 
	<76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com> 
	<40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com> 
	<76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com> 
	<vpqeil2kc6b.fsf@bauges.imag.fr> <76c5b8581002030745g634d6ec1hb9e87b687e58e521@mail.gmail.com> 
	<1088CD70-9D6E-4B97-9A46-BDDE1535B703@wincent.com> <76c5b8581002031049t5558a700qe2e05bb70d175305@mail.gmail.com> 
	<32541b131002031057q866d3q95d0e80a0adf6c52@mail.gmail.com> 
	<76c5b8581002031127m31c39dbbkc7c31d19e4d5874@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:54:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NclJO-0000Fb-Bs
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757609Ab0BCTy3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 14:54:29 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:51744 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757712Ab0BCTy0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 14:54:26 -0500
Received: by ywh36 with SMTP id 36so1637349ywh.15
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 11:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1IYIQ7iYSzfPsR+i5gGFH2vchyIK30cbHBFQCwMkkJY=;
        b=oALm86yoi1pRuOcFN9B2JHneaF8D//ScvMVlCQjRD8IhL7X0lF67J7vxY70zwaK4h3
         js8MSBxflLw/MeKa9HIiozgQl5s/4AA2RSA7fID+oUGHCZZsFQh8OsHIRJ6tHdXF6eKB
         oBr9SwVAawodACk8S1QMgEDkNB8wXyRCTSEC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Cjz4ErGog6jw3v0J02Uacy8fmnTaH2TY/Bu1xdWuMqwLgTiuLPLKaJRurzjh96Vari
         30zOMML7fpmEmaf70sTpoSt+WLcOK9tAAdbQYCUUk1993J0mJanED2HHo7Y10KwZWrja
         0z0XxF0oacyufxgkBdaCbAKIIEO5UcODl4FjY=
Received: by 10.150.160.18 with SMTP id i18mr497590ybe.247.1265226865120; Wed, 
	03 Feb 2010 11:54:25 -0800 (PST)
In-Reply-To: <76c5b8581002031127m31c39dbbkc7c31d19e4d5874@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138877>

On Wed, Feb 3, 2010 at 2:27 PM, Eugene Sajine <euguess@gmail.com> wrote=
:
>> To reiterate what I said earlier: the mtime idea isn't even
>> automatically a bad one. =A0It's about as good as what currently exi=
sts,
>> and the resulting rule (file content or mtime must be modified) is
>> just as consistent as the current rule (file must be nonempty). =A0I=
t's
>> also arguably easier for new users to understand.
>
> OK. Agree on that.
>
>> But you can't just blindly change the system to always work in a
>> different way. =A0People depend on the current behaviour.
>
> I understand that pretty well. My logic is that the most used command
> which is affecting the three is "git commit", therefore this command
> workflow is pretty natural for all users, but the workflow of commit
> --amend and rebase -i which are also affecting the three is
> inconsistent with commit. The user interaction is not the same.

You can't agree with my first statement above and yet still call the
commit --amend behaviour inconsistent with normal commit behaviour.
It is 100% consistent, as others have already pointed out.  Whether it
is consistent is not the problem.  Your insistence on that point is
what's making people argue with you and is undermining your real
point.

Have fun,

Avery
