From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 05/12] t5520: test --rebase failure on unborn branch
 with index
Date: Fri, 8 May 2015 01:44:47 +0800
Message-ID: <CACRoPnQzAjY0bPmHrw2o4Mdzn1Q4Dd587hLXkEPA-qYcYrVGEg@mail.gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-6-git-send-email-pyokagan@gmail.com>
	<CAGZ79kY7gstS1xPcNu4HqmmXA+qg9BKpXZwaHeQ91n7vL2Sa-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 07 19:45:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqPrC-0001g6-Vj
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 19:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbbEGRow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 13:44:52 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:33150 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbbEGRos (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 13:44:48 -0400
Received: by layy10 with SMTP id y10so36151272lay.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9GllC0d0N9sE68ZTcoC3jmppMggyRhnYX6LlOnKgf54=;
        b=x04etliuwAUUx/nNpQxA2b9SL+iGi9tTxQ7X+2Yspyn8vlEIiktqQ9LQKDYEo2KrJA
         Oi8/ENx88WtTr9RcXNC2uK6TFJf5WkMQX6M5+sLA6MH6Aa1HZxZOuAE4QBXObKSwlOZo
         Xj1xd3+1Sw2qx2oc1CiOcAmHnlg3HI5cxhQ7RvByafyzmfqegpF5HthB1iQwA/slgSN2
         fWKCX7v+VqQ0yBI7DAySIPZ3y/0+Jd0XY4jEdZn2gY08+Y1OIchD9q6OIp0kaH92v+cY
         rmVYv8538PmSQLLmSZ7O5C9lNoADSBUR3FnacVYrVeuVkITJxsHTOBOzv1rEOfGedkjx
         orng==
X-Received: by 10.152.87.13 with SMTP id t13mr4023513laz.66.1431020687399;
 Thu, 07 May 2015 10:44:47 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 7 May 2015 10:44:47 -0700 (PDT)
In-Reply-To: <CAGZ79kY7gstS1xPcNu4HqmmXA+qg9BKpXZwaHeQ91n7vL2Sa-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268563>

Hi,

On Fri, May 8, 2015 at 12:32 AM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, May 7, 2015 at 1:44 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> +test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
>> +       test_when_finished "rm -rf empty_repo2" &&
>> +       git init empty_repo2 &&
>> +       (
>> +               cd empty_repo2 &&
>> +               echo staged-file >staged-file &&
>> +               git add staged-file &&
>> +               test "$(git ls-files)" = staged-file &&
>
> I think usually people use
>
>     git ls-files >actual
>     echo staged-file >expected && # you have this already in your 2nd
>     # line in the paragraph
>     test_cmp staged-file actual
>
> to make debugging easier as you can inspect the files (actual, expected)
> after the test has failed.
>
> Personally I don't mind the difference as when it comes to debugging
> using the test suite I haven't found the silver bullet yet.

Ehh, but using test_cmp will litter the test with lots of "echo X
>expected" lines which I find quite distracting.

Just thinking aloud, but it would be great if there was a function to
compare a string and a file, or a string and a string.

But yeah, I guess if the patches are verified to be correct, then I
should change these comparisons to use test_cmp.

Thanks,
Paul
