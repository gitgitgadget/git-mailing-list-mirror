From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 01/11] t6301: for-each-ref tests for ref-filter APIs
Date: Sun, 14 Jun 2015 14:02:54 +0530
Message-ID: <CAOLa=ZRC+mZmXKJnrDFdM9oy4+WrWC0rg7kj_bpNCf=iRSVG2g@mail.gmail.com>
References: <CAOLa=ZRA7jVhs-NixjP+EFqfBNwLEfU-WgEMMQzb5NC+HZDYiw@mail.gmail.com>
 <1434226706-3764-1-git-send-email-karthik.188@gmail.com> <vpqvbeqd7y5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 14 10:33:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43MD-0002Tx-J7
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbbFNId2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:33:28 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34729 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbbFNIdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:33:25 -0400
Received: by obbsn1 with SMTP id sn1so46552439obb.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YmZASfQkDgkNKwO6L+6Tn0cI6NzraU0YdYbeWHdkcIg=;
        b=xsIlePh/ClkvhrSbnaE6iEct4RcxrhhPHa9EZm1ePyvuBi3PQtveeBRGlPHVCMF9T3
         xlUW+086NjU3OZ6r+BOguHbWRCKr/n7fh0nwFmYRgsouYqXvBu6s9DTFnt8QsH99+yIS
         jlqN8IuooU0J2/vfgeMEnWYZxuwlLntoqh0S/rgISelCbOKQe1QkX/Ywk0R0AeTc4lFm
         Mr8t35uJ3V4f/zYxBu2DMQpKh9ntkMj/oRFRXdWpjk6ASRPiOfPCuMhl4kQsFmlJzcc4
         GbyqAwn6ekJ93vQG3yMGVLXXX2yB4F8m72T5zkWPN6tRzNOOLO0TlWPftPFsyMpbBD38
         kYrQ==
X-Received: by 10.202.92.68 with SMTP id q65mr18027117oib.11.1434270804441;
 Sun, 14 Jun 2015 01:33:24 -0700 (PDT)
Received: by 10.182.28.5 with HTTP; Sun, 14 Jun 2015 01:32:54 -0700 (PDT)
In-Reply-To: <vpqvbeqd7y5.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271613>

On Sun, Jun 14, 2015 at 1:42 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +test_expect_success 'setup some history and refs' '
>> +     test_commit one &&
>> +     test_commit two &&
>> +     test_commit three &&
>> +     git checkout -b side &&
>> +     test_commit four &&
>> +     git checkout master &&
>> +     git update-ref refs/odd/spot master
>
> I think you want more corner-cases here. For example,
> refs/headsfoo/master should not match refs/heads, and it's easy to write
> an incorrect implementation for this => test.

Like you mentioned below, currently it's redundant with t6300 and its
purpose is to add tests for new functionality we provide to for-each-ref
via ref-filter. This is done in the next few patches in this series.

>
>> +'
>> +test_expect_success 'filtering by leading name' '
>
> Blank line between tests please.

Noted. Thanks.

>
>> +     cat >expect <<-\EOF &&
>> +     refs/heads/master
>> +     refs/heads/side
>> +     EOF
>> +     git for-each-ref --format="%(refname)" refs/heads >actual &&
>> +     test_cmp expect actual
>> +'
>
> Isn't this test redundant with the content of t6300-for-each-ref.sh?
>
> At this point, you've done only internal refactoring, so you shouldn't
> need new tests (except to fix coverage holes in existing tests).
>
> I guess you're adding this to build more tests on top, but the commit
> message should clarify this.
>

I'll add a note to the commit message about how this test file is so
that we can integrate
more tests in the future for functionality given to for-each-ref via
ref-filter APIs.

-- 
Regards,
Karthik Nayak
