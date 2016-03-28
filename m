From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v9 1/3] parse-options.c: make OPTION__COUNTUP consider
 negative values
Date: Tue, 29 Mar 2016 00:12:08 +0530
Message-ID: <CAFZEwPP5Hq0fM3Fhg+JV-aY6bWozjL6m_bNpb=JhjkUjDJu2sw@mail.gmail.com>
References: <01020153a7ba4e07-f326395b-63df-4f8a-b378-8f387b02d0bd-000000@eu-west-1.amazonses.com>
	<1458815593-11060-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Mar 28 20:42:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akc7E-0007LN-47
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 20:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbcC1SmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 14:42:11 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34411 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbcC1SmK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 14:42:10 -0400
Received: by mail-qk0-f195.google.com with SMTP id u128so14883490qkh.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 11:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=gV/73SRvZDSKHeo59bFSF445/VmGklp7nW9WMuAesvE=;
        b=L31ZGYrPU9gtm3XSHNO61UgDU2Cf6Sgcq8WKIaJPdsNYWFAMXCJrl2J+M9UT3T8iQg
         rASy6AdcYeYR6a4Y0DRx1HIrL+a2xAsp8K6yh7rS9SZxV+z+qlhHh9t+choBsRNNW96g
         NFst1u9hcGeWpVy9YLV0ZwpCpfmxva1H328Hqc+ThzCZw0Vj62nNzmCdj6Bwj4I/xSRS
         MNKGGhAUvXssneqZJ4f2rTglBJTgI790DEtklV7Di7AfUGA3LW4NyBKmTNDMqnkW5bUY
         1uRjKerri1la1K6Gp3j4q/ScApTIUk1gL/JJXar8PzZTf5cuFmVO7NeRIKWEShMd0yJZ
         weGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=gV/73SRvZDSKHeo59bFSF445/VmGklp7nW9WMuAesvE=;
        b=HNkxSIllZE7j6oQFsaopu/uRgw9+AAc861mCs2xjJ7Sotg/Tlp1tBFxq3KIJggEyCw
         r3sbiRkAG4jOkZjKG/NbAV78El3U8W2QOIUpto2D+wpvBlfoRPy3ZRtC2CLTkMDtq/4S
         Vu4NExZbCzyzwg5g07K1ZT6XIDGQ1QiX5qY8onRhA6RGefsmUxMsbJORjDFWPGk+qDFd
         aSr9vWlRMCog4Ovixath+LTDNvYoDFJ9IfOP+/feIQpWxDBMKN59yWQAfLtMfxxB+7xa
         K8+TPekk1wBNzlLCX8L30GrQVyj1H4zFcAFH2pbZgcITdLyb3b92pWP/PF7R+s31a8N4
         WTbQ==
X-Gm-Message-State: AD7BkJL2cw7p7/PCee8k8I92HQJdJoU50Fxkdrs3HXzlLnWdW4L7UlPRrbk0QLWaJnzRhH/3/JHHkZBimCv28Q==
X-Received: by 10.129.155.81 with SMTP id s78mr13339243ywg.24.1459190528950;
 Mon, 28 Mar 2016 11:42:08 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Mon, 28 Mar 2016 11:42:08 -0700 (PDT)
In-Reply-To: <1458815593-11060-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290054>

> A couple of new tests to t0040-parse-options.sh would be great to
> ensure that starting from a negative value works as advertised, i.e.
> at least that '--option' jumps to 1 and '--no-option' resets to 0.

I think adding tests to t0040-parse-options.sh cannot reflect the
behavior introduced by this patch.
This is because setting the initial value of the variable (which is
going to be modified by the argument) is set in test-parse-options.c .
A possible solution will be to modify the test-parse-options.c and
initialize the required variable (verbose or quiet) to "unspecified"
value. But then this will leave one part of the untested ie. when the
initial value of the variable is 0. I could do one thing to test these
both behaviors which is to set verbose initially to -1 and leave quiet
= 0. Since verbose and quiet are both consumers of OPT_COUNTUP, this
can test both the behaviors.

I tried searching for alternatives but could not find any. Is there
something else which you had thought before that would test this
behavior?

If not, then we are left with 2 options, either modify
test-parse-options.c or just hand test it whenever there seems to be a
problematic case.
