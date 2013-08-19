From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] rebase -i: fix core.commentchar regression
Date: Sun, 18 Aug 2013 20:29:37 -0400
Message-ID: <CAPig+cR71yjqQhir8nTHsWuGZX5dgjpRvgdGPd4VMUn+DZok0w@mail.gmail.com>
References: <1376845970-31204-1-git-send-email-sunshine@sunshineco.com>
	<1376845970-31204-3-git-send-email-sunshine@sunshineco.com>
	<7vr4dqn1ko.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, John Keeping <john@keeping.me.uk>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 02:29:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBDLs-0006BU-Gc
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 02:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904Ab3HSA3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 20:29:40 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:55722 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab3HSA3j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 20:29:39 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so2846148lab.6
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 17:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SKTwGJlM678cP4wTe39RDcpideEhauhFziuVElbkAq8=;
        b=j4obkDIOL7L5Li13dN84XaTUT6cIhPU8eDIkZFJHojdpPLvIxTSEA/rhHDfgMFdTj9
         zX6O2fmg/k1coTg+HrEsyp/xkqSuRzXmRWrRqAppMqwm46/8dLNFzs0FLjaj9K6K7PYr
         h36hDlTePBzZyF3Bv+LQxxf/fBvUIK9XzMpSQ1BkxRBO4LwGWOBr83x0s2Jk6VVwEz8o
         RItUa3I6nM7T5U76uyQh4EuK/RSqHfRHgsxT74l/sdFGivnK1nLjzplfrnF8v7XOcr/y
         y2DYgwxMfBvJ3bLKTNncJgy/Qwy2SGe+Ib0jsq3g93fk9+2OEs94NDKnat4TJdYG13gG
         JJeg==
X-Received: by 10.112.87.68 with SMTP id v4mr9300615lbz.2.1376872177985; Sun,
 18 Aug 2013 17:29:37 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 18 Aug 2013 17:29:37 -0700 (PDT)
In-Reply-To: <7vr4dqn1ko.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: -jvMgirj50XVojmyJGMnWM5Vh-s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232525>

On Sun, Aug 18, 2013 at 5:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Intended for 'next'.
>
> Thanks.
>
> Will queue on top of es/rebase-i-no-abbrev, but we have a chance to
> rebuild 'next' after 1.8.4 release, so we may want to squash this
> into the problematic commit when it happens.

That would be fine. Time permitting, I also would like to send out a
couple incremental patches atop 'next' which address your comments [1]
about es/rebase-i-no-abbrev. Those new patches should be suitable for
squashing if you want to go that route.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/232146

>>
>>  git-rebase--interactive.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index 3733312..f246810 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -693,7 +693,7 @@ transform_todo_ids () {
>>       while read -r command rest
>>       do
>>               case "$command" in
>> -             '#'* | exec)
>> +             "$comment_char"* | exec)
>>                       # Be careful for oddball commands like 'exec'
>>                       # that do not have a SHA-1 at the beginning of $rest.
>>                       ;;
