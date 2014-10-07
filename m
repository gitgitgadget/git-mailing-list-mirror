From: Sergio Ferrero <sferrero@ensoftcorp.com>
Subject: configure names for temporary files
Date: Tue, 7 Oct 2014 11:33:16 -0300
Message-ID: <CALpL35mjtg9ge321Vz_kS1wzbYz+z9H5R3L8FcpVSNO3AtZzVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 16:33:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbVpe-0000uu-3X
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 16:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbaJGOdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 10:33:38 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35613 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbaJGOdh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 10:33:37 -0400
Received: by mail-qg0-f51.google.com with SMTP id z107so5456928qgd.10
        for <git@vger.kernel.org>; Tue, 07 Oct 2014 07:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=Q4kGF6xpqhXwphz8bDS6MDOPMK2LobfeK8xDVpr/xV8=;
        b=Hstb1dHJQfx0O684qaTxXj6pJruTitDeLlDV61oF8zX35CVIt8Id9R9jOvG0/7NAtO
         fTrp0f49t3pUmirQbmwRKKKomu0RfRfGu4IEjSNcq1vUt2UngbGyOXTAccFpfXdFzspa
         m0nzge1kt970/IDl1rvqIb9iU7n3iCDm69pgHi+JI+rWuoMKKuPnqlhkWvlKqQQ8p9WK
         6oDHTrpNUU1Rk3NWysaBGz7YLrirWK17wxEXk1cXeuax/6yQxoRWb8DnsXdCbi3UI3sb
         9kDTx8tP2JPnJbYsQRjm3d6BkixMNGur9d95b3LUB3fPryCQwxqPNQK/dWYZrOaHobnl
         OPsg==
X-Gm-Message-State: ALoCoQlQ7Jd6nqt+/XW7HuMIDI1IEDIfvGIAN2DC34gWij93Hm6TJ3lJQUL0n8II4F5p3aE5j0rQ
X-Received: by 10.140.84.84 with SMTP id k78mr18524463qgd.80.1412692416904;
 Tue, 07 Oct 2014 07:33:36 -0700 (PDT)
Received: by 10.140.92.110 with HTTP; Tue, 7 Oct 2014 07:33:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257928>

Hello,

I'd like to configure git with a specific merge tool to merge Simulink
model files.
I have followed the steps to configure the merge tool successfully.

I typed the following on Git Bash:

   git config --system mergetool.<merge_tool_name>.cmd '"<merge_tool_path>"
-base "$BASE" -local "$LOCAL" -remote "$REMOTE" -merged "$MERGED"'

where:

   - <merge_tool_name> is the name of the specific merge tool
   - <merge_tool_path> is the full path to the .exe file for the merge tool
   - the merge tool accepts the -base, -local, -remote and -merged arguments


Then, after a merge detects conflicts on a Simulink model, I run the
following command on the Git Bash:

   git mergetool -t <merge_tool_name> <model_name>.mdl


This command properly launches the GUI of the merge tool, however it
indicates that provided file names are invalid. They are of the form:
<model_name>.mdl.<revision>.#.mdl,
where <revision> is either LOCAL, REMOTE or BASE and # is a number.

The merge tool needs to open the model in MATLAB and MATLAB does not allow
opening models with '.' in their names.

Thus, is there a way to configure Git so that temporary models are of the
form <model_name>_mdl_<revision>_#.mdl instead of <
model_name>.mdl.<revision>.#.mdl?

Other temp file name should also be ok as long as the file does not
contains dots in the part that corresponds to the file name.

Thanks in advance,
Sergio
