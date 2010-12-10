From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Fri, 10 Dec 2010 20:25:25 +0700
Message-ID: <AANLkTimg4Cy83gjzgC3fwg+t=B57b6gzOE98p-=2AR+K@mail.gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
 <201012082051.09730.jnareb@gmail.com> <AANLkTimU6Bhx-2XsZ45_7BmT9fo9MpK8TJWB3zZ=j-i7@mail.gmail.com>
 <201012090254.24999.jnareb@gmail.com> <20101209015926.GA31119@burratino> <7vsjy7h3db.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 14:26:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR2z9-0004tv-K0
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 14:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109Ab0LJNZ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Dec 2010 08:25:58 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33749 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755969Ab0LJNZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Dec 2010 08:25:57 -0500
Received: by wwa36 with SMTP id 36so3707599wwa.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 05:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lQ/vxFcDzVNtQPwU6QpMJhu3U3Aai+D+T58vSOVSo7E=;
        b=O9OoBFUtxsH/uG9V/RNNWvYorPT3pYdT31UVgApc2liVJXT6LR11ypuZdBPsesO951
         jJ+mvUTih34BtfDmpPRCzFjFP73Q+Y5K0XviDEJ6l55l9gf0PUwISpOh1A4XB5gTWoMs
         QzhP3M7ShmgIcxH5GL7/+LaGJ9awJVQbkPK5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XW38fpcjoAAcV5PeqAbTqDUoRPscmKpZjsJT5VwRaEG390xEn/3DRoEJca0H/LHKEW
         qs0at7HPdAfBx8h512O+TVP/G0O15QSDzqjfbRzqTS2gy0GtCByg4/qwcFT+JtWLs7nA
         U5UgZ2T1x4anK2BtQx+fU5c6yRUL21xlY1QQE=
Received: by 10.216.162.70 with SMTP id x48mr2244051wek.4.1291987556634; Fri,
 10 Dec 2010 05:25:56 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Fri, 10 Dec 2010 05:25:25 -0800 (PST)
In-Reply-To: <7vsjy7h3db.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163411>

On Thu, Dec 9, 2010 at 1:22 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Jakub Narebski wrote:
>>
>>> You would need HEAD{^{/foo}^@}x3, or use special rule that HEAD^{/f=
oo}x2
>>> means really HEAD^{/foo}^@^{/foo}, with ^@ used to join them.
>>
>> That said, does ^2x500 really do something meaningful that a person
>> would ever need? =C2=A0I like the
>>
>> =C2=A0 =C2=A0 =C2=A0 ^{:nth(3)/foo}
>>
>> syntax because perl6 supports m:nth(3)/foo/, suggesting a menu of
>> already-defined modifiers to implement when they prove useful,...
>
> Can you explain what the colon in "$commit^{:nth(3)/foo}" is doing?
>
> Are we declaring anything that begins with ':' is a magic inside ^{..=
=2E}
> construct?
>
> I do not think nth($n) without specifying where to start (iow, what t=
he
> current ":/foo" implementation does but with "three levels deep") mak=
es
> any sense, but because the main point of your argument is that we can=
 have
> modifies other than nth($n) that may make sense in such a context, I =
would
> want to make sure anything we come up with is extensible to that synt=
ax.

There's also another similar operation: note search. I don't think we
need to invent another syntax for note search, a modifier for ^{/foo}
may be a good choice.

> On the "starting from any ref" front, I think "!" (as in ":/!some mag=
ic")
> was the introducer we reserved for such a magic some time ago, so per=
haps
> on the "starting from this commit" side, "^{!magic/foo}" may be more
> appropriate?

Can we use ! modifier for other ^{} too? What I have in mind is how to
say ^{commit} that has two parents. Or even better, "search from the
given tip for a commit that has two parents and the commit message
matches 'foo'". Hmm.. too complex. Perhaps "^{grep: <grep arguments>}"
that pulls the whole git-grep functionality in.
--=20
Duy
