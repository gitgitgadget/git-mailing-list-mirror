From: Diogo de Campos <campos@esss.com.br>
Subject: git rebase --interactive "forgets" strategies after --continue
Date: Fri, 9 Aug 2013 16:29:37 -0300
Message-ID: <CAMebvcQ4mzHOnQNPZ-Qpgn4JkxXMBH+ys9PLcJgZ6aL7Xei7jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 21:29:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7sNc-00058M-1a
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 21:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030826Ab3HIT3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 15:29:39 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35817 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030224Ab3HIT3i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 15:29:38 -0400
Received: by mail-wg0-f47.google.com with SMTP id j13so3804432wgh.26
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 12:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=esss.com.br; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ukWjkcHEl3GNrFV3trlkii+vUm2bb39KZZPu9hC/9pU=;
        b=VUPP9jTXW0tsbE0xKibhpJn/Avhgerw+0+/iDBFIaY4SXHk1Du0+vosXFIyR97CtvR
         7isER55w32j/DjL/7lG9at9PjOHQxw/u0KrdAEl9CjgkKXUC9xAi2L0FxMjMUM32PJlr
         axoad0MIfzh5Q6ACNnYYtB0Guo+qAE/FmPHu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=ukWjkcHEl3GNrFV3trlkii+vUm2bb39KZZPu9hC/9pU=;
        b=Q/KyenXZvX3TQiC4PhaFtFySn0t8Ko+jwXS2xRcCpxQLYNz3IE4KssEf0ebs4XYLzh
         wocnV5OIbSZiSWx1c3uAUlcX/yAaB4Fimb2P3d8JzSSgJ7bLItQ8zmL7jfqnc+FtMTEt
         h8/dTT0TiURBOCIXIO4TCzwE/FrHIq4UxZY2KUIvkp5FS16f/B6r8xWXs5qDsMhPhVpY
         jWTfmW2v6pQAfNZggFWrRbeuYab+Ep30tG7r3x6URJ7XXXYi9S08DgW+mQt07dTgNmGY
         veOKP5pdWKxagRlXaw850S/F/ZyhMAA3hy4TVgtV4nYy9lmPkDR6eDnABJVwhkSg2k6l
         lIjw==
X-Gm-Message-State: ALoCoQmaBn1Z4OZwrJw7Okt4Ryoa3H0OvP0j5C55EFlZ9M8E4Lp2n0aVtuAj+0TgDqShblUphJtC
X-Received: by 10.180.211.206 with SMTP id ne14mr2894868wic.30.1376076577573;
 Fri, 09 Aug 2013 12:29:37 -0700 (PDT)
Received: by 10.216.159.68 with HTTP; Fri, 9 Aug 2013 12:29:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232013>

I had some problems rebasing a repository that had empty commits,
which caused the rebase to stop. After continuing it with git rebase
--continue, it seems that the strategies I originally gave were
forgotten.

I quickly glanced at the code, and it seems that a lot of rebase
options are stored in in a $state_dir, but $strategy_args is not one
of them.


Since git rebase --interactive not ignoring strategies
(https://github.com/git/git/commit/db2b3b820e2b28da268cc88adff076b396392dfe)
is a recent change to Git (only available in 1.8.4-rc+), I believe
that this was overlooked.

-- 
Diogo Campos
