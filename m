From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Thu, 2 May 2013 04:45:00 -0500
Message-ID: <CAMP44s1x8pu2B2h3wKmuBDXz3Tqyk9qyijshcD6iN+NpYDCQdQ@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-2-git-send-email-artagnon@gmail.com>
	<7va9oe5y6k.fsf@alter.siamese.dyndns.org>
	<CAMP44s31jyuGGG1Wn9D=D9udkJJdXQfwVAnHuOg02FWinpmn7Q@mail.gmail.com>
	<CALkWK0=B_Ym_ei181eV-WeqJZJyHPv-AmLzYwajm13wftJkB6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 11:45:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXq4e-0004oT-NZ
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 11:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792Ab3EBJpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 05:45:06 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:49369 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab3EBJpD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 05:45:03 -0400
Received: by mail-la0-f44.google.com with SMTP id ed20so332700lab.17
        for <git@vger.kernel.org>; Thu, 02 May 2013 02:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8ekLxZ49MkWXlAV6q74y/H6VMScm05becPXl2qMYFn0=;
        b=sHfTC+G3F+HoZb8VhnTGjCojxN+pnQvlTTwInFAGaMYBH+hd4f1hvgocax9AMboth/
         35aeZWBVL3sa/+uv6sJvnAXe+fYgi9pYzsp8EADt3lGCVGGxLglJNYBXOUVFErGq16q3
         WsKzFXuasQwQSFgv1J3G14h2kVdOxj6t8AwchqQ4XOlLMHu61uNaUEolTgVcBqNEuVig
         2yyqLkeIMX4ucRWYv5+VMRmzmWj21eOEeUS9i6j9jkQnYV4hNIatOxXarhqfm5XiervI
         xhCWKbfnbTtygW3a2+neMC1lfkWaevu/GA3g4cGFleEsURDfZFD6ttokZZa30YaRY5MM
         cykQ==
X-Received: by 10.112.135.70 with SMTP id pq6mr2412052lbb.82.1367487900939;
 Thu, 02 May 2013 02:45:00 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 2 May 2013 02:45:00 -0700 (PDT)
In-Reply-To: <CALkWK0=B_Ym_ei181eV-WeqJZJyHPv-AmLzYwajm13wftJkB6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223185>

On Thu, May 2, 2013 at 4:07 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> [...]
>
> Yes, I'm working on a re-roll.
>
>> Moreover, the symbolic-ref 'HEAD' is quite special, it's mentioned
>> everywhere in the documentation, and the code has special cases for
>> it. It's not reasonable to expect all relevant places to be updated
>> for this functionality, and certainly 'Documentation/revisions.txt' is
>> not the only one.
>
> I'm not denying that HEAD is special.  I'm just improving the general
> support for symbolic-refs, so that the difference between HEAD and any
> other symbolic-ref is smaller.

That is orthogonal to the issue at hand.

>> For example, in Ramkumar's approach:
>>
>>  % git branch -u master @
>>
>> Would replace '@' with HEAD, however:
>>
>>  % git branch --edit-description @
>>
>> Would not.
>
> git branch -u master <any symbolic ref> will work just fine.  It has
> nothing to do with my series.

% git symbolic-ref TEST refs/heads/master
% git branch -u origin/master TEST
fatal: branch 'TEST' does not exist

You mean it will work just fine _after_ your patch series. So it has
everything to do with your series.

> Does git branch --edit-description HEAD work?  Then why do you expect
> git branch --edit-description <any other symbolic ref> to work?  git
> branch --edit-description operates on non-symbolic refs.
>
> Let me make this clear: @ is just another symbolic-ref that always
> points to the same thing as HEAD.  Nothing less, nothing more.

But HEAD is special, @ is not. HEAD is documented, @ is not.

Where is it documented that @ points to HEAD? Where is it documented
that 'branch -u foo @' would replace @ with HEAD?
Documentation/revisions.txt? Sorry, 'git branch -u foo' does not parse
revisions, so that's not the answer. And there's many other places
that don't do revision parsing either.

Your approach is more like a hack, it has the consequences we want,
but it has many other unintentional and undocumented consequences.

If I find a single place where 'HEAD' is hard-coded, and your patch
doesn't replace '@' correctly, would you then accept that there are
unintentional consequences, and that this approach is no the best
precisely for that reason?

>> In my opinion, if 'git branch X @{-1}' doesn't work, neither should
>> 'git branch X @', and that's what my approach does.
>
> Why shouldn't (doesn't) git branch X @{-1} work?

That's a red herring. The fact is that right now it doesn't work.

My patch does what it says it does, and documents what it does, and
does not mess with anything else.

> git branch X <any
> expression with or without a symbolic ref> works fine, and it has
> nothing to do with my series.

No, it doesn't.

% git symbolic-ref TEST refs/heads/master
% git branch -u origin/master TEST
fatal: branch 'TEST' does not exist
% git branch --edit-description TEST
error: No branch named 'TEST'.

-- 
Felipe Contreras
