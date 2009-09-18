From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Avoid the use of backslash-at-eol in pack-objects usage 
	string.
Date: Fri, 18 Sep 2009 12:02:24 -0300
Message-ID: <a4c8a6d00909180802r713d7644mcb4e98ae4352a03a@mail.gmail.com>
References: <1253224300-18017-1-git-send-email-tfransosi@gmail.com>
	 <7vvdjhgrjv.fsf@alter.siamese.dyndns.org>
	 <a4c8a6d00909171506l6c4b6a49i22d7b337a0c6cfa2@mail.gmail.com>
	 <7vd45pgjhr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 17:02:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Moeyl-0007RP-Rr
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 17:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbZIRPCW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Sep 2009 11:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983AbZIRPCV
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 11:02:21 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:60344 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbZIRPCU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Sep 2009 11:02:20 -0400
Received: by yxe37 with SMTP id 37so980248yxe.33
        for <git@vger.kernel.org>; Fri, 18 Sep 2009 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=R/YzfiwnYLOyg/ks/Q6tllPdB3JyTdOQSHu7FnnxGWc=;
        b=oVM9DCXvYjE9Z42Ng/+q3A2r732RNvZ23kInX7lMl/2BRTxO/ODb622h7uBd/wW5+f
         r6zdo/L7S5vrsuU2atYNjMik1M7DAt0I2o05b14JY0YCBXWvmL0KG4tPQ8oPZ9M6HRnO
         lvK8bwaY7+mJiSp3aYOW2QHRbPNeixsSk0wZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bs4bHEr6i4GQ3wxAFMveq/ZJZKtBmLJ27uIFcbJcWVNisP4axCq/eAd+Fzvy19ddJf
         6aIKrrdKsCzLiuN8IYuRwx1cAL88Jattgf4r7bJByvF++0nwMB115el5szuU2Blp3NFM
         wIXjdtjVOxD0scwfoUqSrzSfSDTTmCB8ELlEA=
Received: by 10.100.56.26 with SMTP id e26mr1535059ana.162.1253286144448; Fri, 
	18 Sep 2009 08:02:24 -0700 (PDT)
In-Reply-To: <7vd45pgjhr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128799>

On Thu, Sep 17, 2009 at 9:54 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Thiago Farina <tfransosi@gmail.com> writes:
>
>> On Thu, Sep 17, 2009 at 7:00 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Thiago Farina <tfransosi@gmail.com> writes:
>>>
>>>> +static const char pack_usage[] =3D
>>>> + =A0"git pack-objects [{ -q | --progress | --all-progress }] \n"
>>>> + =A0" =A0 =A0 =A0 =A0[--max-pack-size=3DN] [--local] [--increment=
al] \n"
>>>> + =A0" =A0 =A0 =A0 =A0[--window=3DN] [--window-memory=3DN] [--dept=
h=3DN] \n"
>>>> + =A0" =A0 =A0 =A0 =A0[--no-reuse-delta] [--no-reuse-object] [--de=
lta-base-offset] \n"
>>>> + =A0" =A0 =A0 =A0 =A0[--threads=3DN] [--non-empty] [--revs [--unp=
acked | --all]*] [--reflog] \n"
>>>> + =A0" =A0 =A0 =A0 =A0[--stdout | base-name] [--include-tag] \n"
>>>> + =A0" =A0 =A0 =A0 =A0[--keep-unreachable | --unpack-unreachable] =
\n"
>>>> + =A0" =A0 =A0 =A0 =A0[<ref-list | <object-list]";
>>>
>>> Do you still want to keep the trailing whitespace on these lines?
>> I did this to maintain the same output of the old string, but if you
>> want I can change, what you suggest?
>
> If you need to add or remove an option to actually _change_ the strin=
g, a
> patch like this, as a preparatory step before the real improvement, w=
ould
> be a very welcome clean-up. =A0I however would suggest doing nothing,=
 if
> this is the only patch you are going to send against this program in =
the
> near future, to be honest.
OK.
>
> Even though we do not have any other patch in flight that changes thi=
s
> program at this moment (as expected, because we are in -rc freeze), w=
hich
> means there is not much risk for this patch to cause needless conflic=
ts
> with others, we generally avoid code churn like this one, as a princi=
ple
> for a maturing project.
This release candidate freeze is a period that no one can send patches?
If you could, point me to a documentation about how is the development
process adopted by git.
As I can see, anybody can send patches to this mailing list for
review, but if no one cares about the my patch for example, it doesn't
get a review and any feedback.
In a web review tool, the patch is assigned to someone review it, but
here it is impossible, so how the things are tracked here? Only you
merge the patches into the master branch? When someone send a patch,
you get it, make a topic-branch in your private repository, and if it
is good it will be merged into 'pu branch'? And what did you mean with
code churn?
>
> The _very best_ thing you can do for the project on this particular i=
ssue
> is to keep an eye on the list and the next time somebody wants to pat=
ch
> this program in a way that affects the usage string, remind that pers=
on to
> first clean-up the string without changing anything else as a prepara=
tion
> patch; I however admit that I am asking a lot more work out of you.
>
> A real improvement patch from that somebody _could_ be to remove the
> trailing whitespaces from the output string, and in that case I would=
 not
> mind if two patches (one preparatory patch which is this one, and the
> other being the removal of trailing whitespaces) were squashed togeth=
er.
> In fact, in such a trivial case, it probably be better to squash them=
 into
> one.
If I understand correctly, do you want a function to remove the
trailing whitespace from a given string? Like the functions that work
with whitespaces in ws.c?
>
> And that somebody _could_ be you.
>
