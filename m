From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv10 02/10] receive-pack.c: die instead of error in assure_connectivity_checked
Date: Mon, 5 Jan 2015 13:15:43 -0800
Message-ID: <CAGZ79kZUiwEbcSPk3Td60umixvh_Q7jXTGoLemKLYsvX1ty39w@mail.gmail.com>
References: <CAGZ79ka8TMvF1s=ZL=4Lj1EaDrLVn8HRA2PR4JLAHWasHmvkFA@mail.gmail.com>
	<1420482355-24995-1-git-send-email-sbeller@google.com>
	<1420482355-24995-2-git-send-email-sbeller@google.com>
	<20150105201728.GK29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	ronnie sahlberg <ronniesahlberg@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 22:20:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8F09-00066q-9n
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 22:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbbAEVPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 16:15:44 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34992 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbbAEVPo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 16:15:44 -0500
Received: by mail-ie0-f174.google.com with SMTP id at20so20477551iec.19
        for <git@vger.kernel.org>; Mon, 05 Jan 2015 13:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nR6SqfErRYR528X0gpvq1rNCDN0u7/+rTFgHbqizd8U=;
        b=HCeTTCYbamid0lDHiC8BlyUib9fCZ6jkKnVhJSI4GSQFTT9CieWq7DIcWHYRMa+p6q
         dmF0Pa+Q5G5KKfdtMDvOkha+Frh6xj6eXk3yQ/74nalTa/oeiR63UwG0966R28wqyM6C
         ksMBVQc50W+g9iQ9fb/KxxHFn5g0XW6MZjg7z0eZWTvvAqx36DhPXKmnJ1xQebSHf4m+
         JWCvunRtxKczpweXY87rTkK5M3K1d8Uq/q5D97Uh4MzZnXcEM+SdzeSpPfto64pqY0B+
         k7gwjZYLhjTrm42qgIn/tJ+YTB4kjKy3iQHGO37S0wjsZyrG0AlbvjQobykygZXjpWuB
         tVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nR6SqfErRYR528X0gpvq1rNCDN0u7/+rTFgHbqizd8U=;
        b=TEwhY8EtX+RM34kq1VRD4irono78c1fIg12SwLVpEZrX8X63x9goQMul40IugWjv4S
         5/PLJUlPrhYE0yqHJoEQSHgySicy8wkO9R4krHzcl/CCASJQqW8wcY7cwOLE4AuVleRR
         WQHM3eLwTOlb++NKSMYxSpv0Tj5cA7Jbn9QmauhgOcctajmkrlsVTJDqytwChhvV4xYW
         2Zk5PWl1Gaza/ReBIdzJL6U7c0xrHcWW/CcYqmIE5v59D9n5VC9Py2Nq2q2O+lqCGGu+
         aJFszH6EnjjgRs51t9YzpNbzspTD8iZLS2sdUPFbtjZNCylFpIbytS8xnYCIZfplmhYa
         4tEw==
X-Gm-Message-State: ALoCoQnll28ZbpStyk+lywfOZxgqSr0YhPJ2fqbX6kErN2GF339P0RbjHlwDn+AlHy79COOFU1jr
X-Received: by 10.107.153.147 with SMTP id b141mr82224694ioe.49.1420492543202;
 Mon, 05 Jan 2015 13:15:43 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Mon, 5 Jan 2015 13:15:43 -0800 (PST)
In-Reply-To: <20150105201728.GK29365@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262034>

On Mon, Jan 5, 2015 at 12:17 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -1055,15 +1055,15 @@ static void assure_connectivity_checked(struct command *commands,
>>
>>       for (cmd = commands; cmd; cmd = cmd->next) {
>>               if (should_process_cmd(cmd) && si->shallow_ref[cmd->index]) {
>> -                     error("BUG: connectivity check has not been run on ref %s",
>> -                           cmd->ref_name);
>> +                     die("BUG: connectivity check has not been run on ref %s",
>> +                         cmd->ref_name);
>
> This could stay as error() so that the caller gets to see the list of
> refs that didn't experience a connectivity check.  Or if that list
> isn't important, this error/die call could be dropped and the
> 'checked_connectivity = 0' setting would be enough.

Right. I was once again writing patches without brain activity.
So we'd keep this as an error.

>
>>                       checked_connectivity = 0;
>>               }
>>       }
>>       if (!checked_connectivity)
>> -             error("BUG: run 'git fsck' for safety.\n"
>> -                   "If there are errors, try to remove "
>> -                   "the reported refs above");
>> +             die("BUG: run 'git fsck' for safety.\n"
>> +                 "If there are errors, try to remove "
>> +                 "the reported refs above");
>
> I find this error message misleading and confusing.  It makes it seem
> like this is an expected error that we are trying to help the user
> recover from.  Instead, something impossible has happened.  "Try to
> remove the reported refs" is actively harmful advice --- that would be
> a way for the user to work around a serious bug instead of figuring
> out what went wrong and getting git fixed.

Maybe we should do both?

    die ("BUG: Some refs have not been checked for connectivity."
          "Please contact the git developers (git@vger.kernel.org) and"
          "report the problem. As a workaround run 'git fsck'. If there"
          "are errors, try to remove the reported refs above. (This "
          "may lead to data loss, backup first.)"

Just thinking out loud:
We are using die(...) for two kinds of problems. Either because of
some bad condition given to us by the user (wrong/meaningless arguments)
which we then to refuse to accept.

The other case is usually die("BUG: Git is broken in some way") as we're
discussing here. Would it make sense to have an extra die_bug function,
which amends the reported error string by something like

    "Please contact the git developers (git@vger.kernel.org) and
report the problem."

as above?

Thanks,
Stefan

>
> Jonathan
