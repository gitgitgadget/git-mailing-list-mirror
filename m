From: Stefan Beller <sbeller@google.com>
Subject: Re: git checkout --theirs fails
Date: Tue, 15 Mar 2016 14:35:18 -0700
Message-ID: <CAGZ79kbzrpHowSLfCjB6wVfeX_3MUXAjD0rQdcugryWPMrTazQ@mail.gmail.com>
References: <56E845F0.9020609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Susi <phillsusi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 22:35:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afwcg-0001NK-QM
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 22:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbcCOVfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 17:35:23 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34223 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472AbcCOVfT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 17:35:19 -0400
Received: by mail-ig0-f180.google.com with SMTP id av4so98645913igc.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 14:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=c2H1JyEMUy3Gp2PuWy7D+xno447XZYnsZWOEAyeHLFU=;
        b=RKgW7Bpa1xdszwQcUAERdlx+kgO+s0ofAqVeBAOEm5fUwBMzAkD6aGZoDEZ3gxerw9
         EKYnHAajtcD7obppTGWNGTkuu7aqlKMRf7G+1nsHKVLsX/vIMmawPWdHTdQT/0BypqXd
         jDIxnJWdwDELr+2ghXJc3FWjoJOXTFwbvt+L2X0sK6rOEuweUVyj3zPQccTBD80ebhtn
         XQQv0j7mgZjN5RtGsXKMbPpJUoM2op1wRXX/TIvb0LP+HOZoLIVzKNCbmNr83txxMMs3
         ZhFSRR5gioMvPSP4d9eaj0VTBJrsd1LD1nYF68OGbbJ+rvTc58IpPZApfj4coEbK9jDZ
         51Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=c2H1JyEMUy3Gp2PuWy7D+xno447XZYnsZWOEAyeHLFU=;
        b=QzDt+VyVc3kuy1M81HDhzWQGScqWL18nmLECWLMtPCS943P17EgiLinyomT4rr0676
         P3QFcxsYBSLtEnpclG+h6mxnwYo7NL+uxiCKhYUmqhnscqlUIIS00KDA//PbHDYCl5M6
         6hmrxDlQUkhql4LGnzyIb4MDli0pSI3LcD8Pc1i5NUzBzWkC3s5ofKlIECm3Tu6/8MFI
         ccHzkrBW+E3YFG7k/42z0L0+0cKMW6tfEYsSIX3/n94rSMaRosmTqdxDKa58Bip1tMAD
         VM7K6Jy0oe9njwepITRrfv9zFr7g1es8W3NtFU7mKd8t5BdGMcsoHWn/g7axTM9lgCzD
         vhNw==
X-Gm-Message-State: AD7BkJLJRmQIJD78lEeGQ9cz8ATaJ/X+FPuLhZvcfFGD9JJHf3PQdYKVF7FKMTAh6niRB6IgwDr+vDA7WETo5ckZ
X-Received: by 10.50.43.226 with SMTP id z2mr990940igl.94.1458077718378; Tue,
 15 Mar 2016 14:35:18 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 15 Mar 2016 14:35:18 -0700 (PDT)
In-Reply-To: <56E845F0.9020609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288918>

On Tue, Mar 15, 2016 at 10:27 AM, Phil Susi <phillsusi@gmail.com> wrote:
> I'm doing a rebase and got some conflicts.  I just want to take their
> version of all files, but git checkout --theirs complains:
>
> --ours/--theirs' cannot be used with switching branches
>
> What gives?  I'm not *trying* to switch branches.  I just want to
> resolve the conflict by taking their version.  If I try git checkout
> --theirs ., then it complains that not every single file in the
> directory has a "their" version.  So?  Take the ones that do.

I think for checking out files you'd need to add the file names.
In case of a collision between branch name and file name, even add
a double dash:

    git checkout --theirs -- file/name

>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
