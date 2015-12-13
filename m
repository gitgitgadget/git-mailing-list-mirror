From: Luke Diamand <luke@diamand.org>
Subject: Re: Bug: git-p4 can skip changes when syncing large from multiple
 depot paths
Date: Sun, 13 Dec 2015 19:04:43 +0000
Message-ID: <CAE5ih79iZDx58dagzNpND=QFOQssb2BhuTTQu=KDrdrNoyb0XQ@mail.gmail.com>
References: <1449888770698.39553@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: James Farwell <jfarwell@vmware.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 20:05:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8BxX-00046I-Ld
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 20:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbbLMTEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 14:04:45 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34072 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbbLMTEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 14:04:44 -0500
Received: by mail-ig0-f170.google.com with SMTP id g19so69305241igv.1
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 11:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QBS5nrRu6xrLZ6jkVPPS2//zKRGG/tIuPSMqLl8LfyA=;
        b=GOqtn0VvoIl3ZAsON8aP1R2V7GnMnPm/+cPsEJxf7xpTbtiNPn/T/sPofhijMpVAQp
         r68NkU+sLuqH2bWZgMjMJ61jVYqarowK48o1aiYzJt1HKKp7ZYdRqiJmVJEHDoL+Obs1
         6kB48t6OJs9zTBwhT4QJ+mPL7ircVT/mJ/wsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=QBS5nrRu6xrLZ6jkVPPS2//zKRGG/tIuPSMqLl8LfyA=;
        b=m7Jn1NDpDCsh4GXLrQpiW32DsmrmmOJNzgmvrq366Nc0Fte6A7vjrCOD66NNrCB8vx
         df+n7MZp5tjvqbVMkXtnUHNTlcIhG461z9tJG/0d8OPrjzL0aer+mfjozLCJLVgmAX9W
         78kH4qqBIQE8RK7rj0TJ0+sfGsIi7nZWBJv4goz2z/8sgWhn7IUPedrHwsOect530MTs
         HTS7l5xLNVE2gS8lmf4/5N6UPZ4dRzuEq7rA2tB3bTrYZM9OPbOp1UH1O7lQwAeUYD2s
         tW/SdXQJdGPnxgnxtqVcaeSTLJLjwUbql3KSTcLTQzOui5oHRerC6eqYltOnKbl+m42I
         qoLw==
X-Gm-Message-State: ALoCoQk78XZX+8lnbIEZcAqFDR4h4da7h6HgcJb1GC7hdyCTKMXzT8hoE/cJ3K7vSxLTspqCpybuC4zviP/PmylNMBy57yuEpw==
X-Received: by 10.50.3.71 with SMTP id a7mr13198800iga.80.1450033483829; Sun,
 13 Dec 2015 11:04:43 -0800 (PST)
Received: by 10.79.94.194 with HTTP; Sun, 13 Dec 2015 11:04:43 -0800 (PST)
In-Reply-To: <1449888770698.39553@vmware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282341>

On 12 December 2015 at 02:52, James Farwell <jfarwell@vmware.com> wrote:
>
> Reproduction Steps:
>
> 1. Have a git repo cloned from a perforce repo using multiple depot paths (e.g. //depot/foo/ and //depot/bar/).
> 2. Add changes to the perforce repo in both depot paths. (e.g. 5 changes in each)
> 2. Do a "git p4 sync --changes_block_size n" where n is smaller than the number of changes applied to each depot path. (e.g. 2)

Thanks - this is definitely a bug. Let me see if I can work up a
testcase for it and a fix.

Luke
