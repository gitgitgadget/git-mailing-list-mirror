From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Git submodule removal and replacement results in failures
Date: Fri, 13 Feb 2015 10:48:38 -0600
Message-ID: <CAHd499CyBk-Mt+AwLMrOjOoXKTJDk4hZBDptt3iXbo8tCiTx3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 13 17:48:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMJQ3-0004bn-E0
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 17:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220AbbBMQsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 11:48:39 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:42030 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbbBMQsi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 11:48:38 -0500
Received: by iecrp18 with SMTP id rp18so5475369iec.9
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 08:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=Cl6iAIBszsRVta5VpvqKOtYaQ7scnlTiOntVZN1TfcE=;
        b=TCTBLy3LVV9Ql12Bftp2paijvAwYNaOxKXcbWKU+S48cDDfHDERm8tnvglUz/mpxnl
         RIYexncJ7a8s1be3ElAtWiRFn5l5XJIqhWeavIvBDoWmWMr2HgeitNHG8QrSLZ6w8AgE
         2zaXrVqj85dvNG7S154mbhYlV9W83uX+kq49al/W1pfSHd3uM/SaoktnsnkoroRvSFBm
         y7Fpi85WiJh0fb1q3McQCrVnyFusCkkZDCVbUQPQ0sxagvZOXdH9/XxxKFGtGebxzte+
         z1F9+T6lJp3hCf/ZmSxnzORCJF+M19g4sCACkGF8ROBD5hnUKcQQ8HoXazlp4TPJkNd0
         ABBA==
X-Received: by 10.107.151.80 with SMTP id z77mr12876990iod.51.1423846118176;
 Fri, 13 Feb 2015 08:48:38 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.49.72 with HTTP; Fri, 13 Feb 2015 08:48:38 -0800 (PST)
X-Google-Sender-Auth: COI1jBWXS723i0SDrproEmJ3Jhg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263812>

Let's say I have a submodule set to directory "foo". If I remove this
submodule in 1 commit (git rm -f foo) and then in a 2nd commit after
that, physically commit those files, the next person that does a `git
submodule update --recursive` results in failure because it says it
can't overwrite files.

I'm guessing what happens here is that when the submodule is being
updated, it is not de-inited first, so the 2nd commit is trying to be
applied but the submodule files aren't removed first, so it thinks it
is going to replace unversioned files.

Is there a way to make the submodule files be removed during an
update, so that subsequent commits that may add files to replace the
submodule aren't overwriting unversioned files?

Thanks.
