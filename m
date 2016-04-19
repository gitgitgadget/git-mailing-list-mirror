From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Tue, 19 Apr 2016 09:13:37 +0100
Message-ID: <CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jan Durovec <jan.durovec@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 10:13:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asQnE-0005bn-ES
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 10:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbcDSINr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 04:13:47 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33440 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbcDSINn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 04:13:43 -0400
Received: by mail-ob0-f177.google.com with SMTP id tz8so6309912obc.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 01:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Lpt5SOGBQoX8ox8Kln7YTmekzTT33Fr+joM307zslgI=;
        b=V98UN7iH7S3JvjvqgdWbYTMS5/NxjXG8dIfD3sR0aWIElwRsd+6wvrrTjE4ojfCGI0
         APV/mjrAEnZCnBhEIggwPBHHseT0y/tlY05px4SI/vXCY4GZ3KsdvqWKRE3oAA5Aoc0l
         dd10tlVLom6JB46zWvwAs3vBN1Xsk72VQUKms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Lpt5SOGBQoX8ox8Kln7YTmekzTT33Fr+joM307zslgI=;
        b=Lf/y+gR7xN0fQIX4SG2sa28oicazKevdzJJ7R05eyq4tdxlLg6dJfYi4jlDPMn7azu
         Eq092lheaTFqmPRbn33QAoP98/pWlRRlINTSTp7SO8LQLc6Px1mj6btyZoYh8CoCt0yb
         41c97FCnRGPskInl7J6SNcqLQoMS2x2Sp11IfhTKm3pO6ytOXva0mQ933g8+sDr95Lna
         IJU4joY7YucifTMOSW6kMeOvysja9PIFLQtdmAW1PfvoPPAx54vegfUPRvpBNZt9IrGw
         tq6QtlM1S4vItaHCdFbr/9qIB2fwVJPkLqv8QI3o5jkyB3iPPQVHwwBwOMObXq8diUIj
         ZzqQ==
X-Gm-Message-State: AOPr4FW26DHY4L+2Eky1ILVZOGpY625xUuWwPBfW/eQvORXSC3D2NqyNG9c9g2CBh5r2O9n9MeF2q0zQEgYHdw==
X-Received: by 10.60.63.84 with SMTP id e20mr536542oes.37.1461053617800; Tue,
 19 Apr 2016 01:13:37 -0700 (PDT)
Received: by 10.202.75.210 with HTTP; Tue, 19 Apr 2016 01:13:37 -0700 (PDT)
In-Reply-To: <xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291851>

On 19 April 2016 at 02:15, Junio C Hamano <gitster@pobox.com> wrote:
> Jan Durovec <jan.durovec@gmail.com> writes:
>
>> When migrating from Perforce to git the information about P4 jobs
>> associated with P4 changelists is lost.
>>
>> Having these jobs listed on messages of related git commits enables smooth
>> migration for projects that take advantage of e.g. JIRA integration
>> (which uses jobs on Perforce side and parses commit messages on git side).
>>
>> The jobs are added to the message in the same format as is expected when
>> migrating in the reverse direction.
>>
>> Signed-off-by: Jan Durovec <jan.durovec@gmail.com>
>> ---
>
> Thanks for describing the change more throughly than the previous
> round.
>
> Luke, how does this one look?
>
>>  git-p4.py              | 12 ++++++
>>  t/lib-git-p4.sh        | 10 +++++
>>  t/t9829-git-p4-jobs.sh | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 121 insertions(+)
>>  create mode 100755 t/t9829-git-p4-jobs.sh
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 527d44b..8f869d7 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2320,6 +2320,15 @@ def extractFilesFromCommit(self, commit):
>>              fnum = fnum + 1
>>          return files
>>
>> +    def extractJobsFromCommit(self, commit):
>> +        jobs = []
>> +        jnum = 0
>> +        while commit.has_key("job%s" % jnum):
>> +            job = commit["job%s" % jnum]
>> +            jobs.append(job)
>> +            jnum = jnum + 1
>
> I am not familiar with "Perforce jobs", but I assume that they are
> always named as "job" + small non-negative integer in a dense way
> and it is OK for this loop to always begin at 0 and immediately stop
> when job + num does not exist (i.e. if job7 is missing, it is
> guaranteed that we will not see job8).

This is OK - P4 jobs have arbitrary names, but this code is just
extracting an array of them from the commit by index.

>
> Shouldn't the formatting be "job%d" % jnum, though, as you are using
> jnum as a number that begins at 0 and increments by 1?

Python seems to handle this by turning jnum into a string.

>
>> +        return jobs
>> +
>>      def stripRepoPath(self, path, prefixes):
>>          """When streaming files, this is called to map a p4 depot path
>>             to where it should go in git.  The prefixes are either
>> @@ -2665,6 +2674,7 @@ def hasBranchPrefix(self, path):
>>      def commit(self, details, files, branch, parent = ""):
>>          epoch = details["time"]
>>          author = details["user"]
>> +        jobs = self.extractJobsFromCommit(details)
>>
>>          if self.verbose:
>>              print('commit into {0}'.format(branch))
>> @@ -2692,6 +2702,8 @@ def commit(self, details, files, branch, parent = ""):
>>
>>          self.gitStream.write("data <<EOT\n")
>>          self.gitStream.write(details["desc"])
>> +        if len(jobs) > 0:
>> +            self.gitStream.write("\nJobs: %s" % (' '.join(jobs)))
>>          self.gitStream.write("\n[git-p4: depot-paths = \"%s\": change = %s" %
>>                               (','.join(self.branchPrefixes), details["change"]))
>>          if len(details['options']) > 0:
>> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
>> index f9ae1d7..3907560 100644
>> --- a/t/lib-git-p4.sh
>> +++ b/t/lib-git-p4.sh
>> @@ -160,6 +160,16 @@ p4_add_user() {
>>       EOF
>>  }
>>
>> +p4_add_job() {
>
> Not a new problem in this script, but we'd prefer to spell this as
>
>     p4_add_job () {
>
> i.e. a space on both sides of ().
>
>> +     name=$1 &&
>> +     p4 job -f -i <<-EOF
>> +     Job: $name
>> +     Status: open
>> +     User: dummy
>> +     Description:
>> +     EOF
>> +}
>
> It may be better without $name?
>
>> +test_expect_success 'check log message of changelist with no jobs' '
>> +     client_view "//depot/... //client/..." &&
>> +     test_when_finished cleanup_git &&
>> +     (
>> +             cd "$git" &&
>> +             git init . &&
>> +             git p4 clone --use-client-spec --destination="$git" //depot@all &&
>> +             cat >expect <<-\EOF &&
>> +Add file 1
>> +[git-p4: depot-paths = "//depot/": change = 1]
>> +
>> +             EOF
>
> As you are using <<- to begin the here document, it is easier on the
> eyes if you indented the text with HT, i.e.
>
>                 cat >expect <<-\EOF &&
>                 Add file 1
>                 [git-p4: depot-paths = "//depot/": change = 1]
>
>                 EOF
>
> I won't repeat the same for other instances below.
>
> Thanks.

Modulo Junio's other comments, this seems fine to me. I tried it out
on a scratch repo and it works very nicely, thanks!

Luke
