From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v5 0/2] bisect--helper: rewrite of check-term-format()
Date: Sat, 7 May 2016 18:37:50 +0530
Message-ID: <CAFZEwPOA9c8eQAacnuB1n=juOhN1zsMdzcupS3ijqwYFPRrW4A@mail.gmail.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<xmqqtwia25qc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 15:14:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1az1xh-0002T4-ME
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 15:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbcEGNHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 09:07:52 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33293 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbcEGNHv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 09:07:51 -0400
Received: by mail-yw0-f195.google.com with SMTP id y6so19642717ywe.0
        for <git@vger.kernel.org>; Sat, 07 May 2016 06:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ahLa0ZffswE7Z3417ORmre3ttLW3Rb7VYXxVe7QdkGQ=;
        b=wnc03oC8esqNj5nxjy1UInty/xTAiTAtpQkXslfRxCYLuuY7aUK9yVRpSWdxfZ6upy
         OxyJes98cjUT8tA+kXYdRxABSULFaN24geJ5CYXB4Z1+LaFLkxJI/9vltP3xt7POO0Qm
         QRkqQEhZLWCJGuoiE6cLfEFEUrEp7yBQBJ6TNWGlNpO7H5xUaqSlh4pRjYSvq66QqT9/
         MKETsrYM7f79VNqMHUQQGHP4lZolrvOY1VRMGN61yxW0/nISNE4EUSyYrdn1jopeXKhf
         L+UqZKGgz0DP8fhbmUOSGKMQNZ1o/mdrmfRVj6PSHCEdF9IV6uTlO2Fhg8iSJ+i3tzbr
         9wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ahLa0ZffswE7Z3417ORmre3ttLW3Rb7VYXxVe7QdkGQ=;
        b=gpIHHLqrFcHU6UoIcOnAnX4UP/WafYTqthfwrJJ30VUFKcgTCX3nrX2CT/UPgi4WP2
         70Q6B5Zt6y/UBCcxVDzKuwu2fiOOiqXZqHs2y+ZQyecaB3fxPJreAV6v2NaHCdr+C3ji
         SnHeqHVX+v9bNeJtKRbDkgcHVvqphf6agves9+XbnhU8HbviAfoXRxZdJSeW9o38OY53
         4ohMZGDk9xddQ9+JWyKqEzaBe48he8kcsDBX+EvbtNZ5AF5KqtmCdSgUdsO90s1C2UAn
         r8gSU7i4GFf6P3D9IfHtkq8xaeRtxZdsgZOokTfK8fYBUlXA4VZHqULGV7z/ESueb7Zg
         SqoQ==
X-Gm-Message-State: AOPr4FWixVM1eYtd5vnxXSRXWfCfRje1O9BvVCpBc97DYvkf5wqzKgOFOeuxOqiaawjZ6xSIvj0GNENzoYN5qg==
X-Received: by 10.129.134.133 with SMTP id w127mr14671325ywf.252.1462626471006;
 Sat, 07 May 2016 06:07:51 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Sat, 7 May 2016 06:07:50 -0700 (PDT)
In-Reply-To: <xmqqtwia25qc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293894>

On Sat, May 7, 2016 at 3:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> A very interesting fact to note:
>> I made a mistake by dropping of the first argument 'term' in the function
>> one_of() and compiled and the test suite passed fully (which was pointed
>> out by Christian). This shows that the test coverage is incomplete.
>> I am
>> currently writing tests to improve on that coverage. It will be included
>> separately.
>>
>> Link to v4: http://thread.gmane.org/gmane.comp.version-control.git/293488
>>
>> Changes wrt v4:
>>  * Stick with 'subcommand' in the commit message.
>>  * Rename enum as 'subcommand' to make it singular.
>
> I've already said what needs to be said on this.
>
>>  * s/bug/BUG/g
>>  * Drop _() in the default of switch case
>>  * Use some suggestions for commit message no. 2 and also include why I am
>>    using subcommand.
>
> I am not particularly impressed by the rationale, though.
>
> As a starter project to show that you learned how to add a new mode
> to bisect--helper, check-term-format may be a small enough function
> that is easy to dip the toe into the codebase, so in that sense it
> may be an appropriate first step, but otherwise it is not all that
> interesting, especially when we _know_ that it will be discarded.

I do understand that check-term-format was a suggestion just for me to
"Get a taste" for the project.
I have now also converted write_terms() function. I have made a PR[1]
which needs a few things to be addressed.
Just a summary of what the PR does:
 * Converts the shell function write() terms to C
 * Adds a subcommand for write_terms()
 * Remove the subcommand for check_term_format()
 * Call the method check_term_format() from inside write_terms().

Do you want me to include both of the functions check_term_format()
and write_terms() in the same commit or a different commit.

OR,
I completely missed your point and you want me to go the Eric Sunshine's way?

[1]: https://github.com/pranitbauva1997/git/pull/3
