From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/4] rev-parse: fix some options when executed from
 subpath of main tree
Date: Tue, 10 May 2016 03:49:28 -0400
Message-ID: <CAPig+cSZ9PXr4Wogt2EJAJyapso8hZVucQ2yvJpCRK35a2j8jg@mail.gmail.com>
References: <1461361992-91918-2-git-send-email-rappazzo@gmail.com>
	<20160429135051.15492-1-szeder@ira.uka.de>
	<CANoM8SWBzFiHGc3zAwndyx+GUkWQGDoaewVVQtH-06jazAn8uQ@mail.gmail.com>
	<20160506161312.Horde.7i8_sE5ISIqccneOIfinvCX@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Rappazzo <rappazzo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue May 10 09:49:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b02Q9-00044g-Qz
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 09:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbcEJHtb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 03:49:31 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35171 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbcEJHt3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2016 03:49:29 -0400
Received: by mail-io0-f195.google.com with SMTP id i75so154962ioa.2
        for <git@vger.kernel.org>; Tue, 10 May 2016 00:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=Jao8CAr0k4uTjn9E366MwwvPqesIIQMfKXiPk719rWI=;
        b=lidSPcXpweR4t9VeiiIMT+PSsOkM+ZvhxVK1Z1k4Gc89ANtV8V+jdabBj+E0V5yeV3
         pncwx0VL/vCIpC+Op6a3CqaFGnOQBumfY23RPZzKwuBgOYAbkJTtIYzboPgZP3lYgzvZ
         Q54Bgb3F1y/qJLfldHgmzNClkBNftJWtLh982IQe0VDV76fzHaS9MSkWn4kK7k3CPCKC
         uxI8sloa5KbZ+3QybZdGkwFc+m/ZNHGoNCuJDmk3v5TPXBUqDHRpDc6cAPFlYn8BYMqZ
         z3v/aulgEBMtmFyuhN5fNetNKzajrTLzD9g54Z/43Zjm8yuWTqsZpxAntlFY0bfF3P2W
         ox4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=Jao8CAr0k4uTjn9E366MwwvPqesIIQMfKXiPk719rWI=;
        b=P+2VSUam6wlchNMi78uCJ8MmJJemR4wEEe2COyVYKuyBd6VPH/ZIzvRbUs/bi266by
         ZlYvUSvj0XChZ/COeOJi7FALPDxLwZkTlf2msmi2fQZ1ZVI1iIk7NEmu7YGw6iTrxgC2
         a4rkbmKvA7z3UXCTctGgRoYmvy+ML+G4gWL0VsyVfXjRoqJehGOgNWIcWNetJEhp6Mfw
         TUUAEc+fFYrW3Tau1du4c8jdMEUPxfLWmYuPZPd3vu9gVS3bDfxJ1D3GZsNGzd3tIMJ/
         NQ4AvACYzwJV6n3PGVWQ7WiN0ChoxP8TyIk1N0aOnf/SHwSU6olP4EOxeXaccfco+9DY
         k2sw==
X-Gm-Message-State: AOPr4FWiH3txms+V0FGvJqzuAokxcd5bGqj8bN17OSu4UW9xMPp9/ORlT81FYKe131uFNX0eGlEShbZifm6Y8Q==
X-Received: by 10.107.47.37 with SMTP id j37mr40254807ioo.168.1462866568992;
 Tue, 10 May 2016 00:49:28 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 10 May 2016 00:49:28 -0700 (PDT)
In-Reply-To: <20160506161312.Horde.7i8_sE5ISIqccneOIfinvCX@webmail.informatik.kit.edu>
X-Google-Sender-Auth: 33SNfl0SCzXg45dYoUh0LWo95UA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294114>

On Fri, May 6, 2016 at 10:13 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> Quoting Mike Rappazzo <rappazzo@gmail.com>:
>> I'll try to reword this to make it indicate that the value isn't
>> always incorrect.
>
> Not sure I understand your intention about rewording, in particular t=
hat
> "isn't always incorrect" part.  Just to make sure there is no
> misunderstanding let's have a look at the two broken cases:
>
>    $ git -C t/ rev-parse --git-common-dir
>    t/.git
>
> Obviously wrong.
> This is what you correctly described in the commit message as
> "incorrectly returns a path which starts 'sub/path/.git'.
>
>    $ git -C t/ rev-parse --git-path objects
>    .git/objects
>
> Wrong as well.  It would be correct if we were at the top of the work=
ing
> tree, but we are not.  It must be relative to the directory where '-C=
 t/'
> brought us.
> Your description in the commit message implies that '--git-path <path=
>'
> is wrong in the same way as '--git-common-dir' is, i.e. in this case
> would also return the relative path starting with the subdirectory.
> That is apparently not the case.
>
> My point in the previous email was that both are wrong when executed =
in
> a subdir of the working tree, but they are wrong in different ways.  =
And
> they are always wrong when executed from a subdir of the working tree=
=2E

This explanation argues strongly in favor of placing each fix in a
separate patch[1] so that each commit message can be tailored to
precisely match the problem being fixed. Bundling the corresponding
tests with the fix would be a bonus; no need for a lead-in patch
introducing the tests en masse, and no need for test_expect_failure.

[1]: http://article.gmane.org/gmane.comp.version-control.git/293001/
