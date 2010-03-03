From: Jay Soffian <jaysoffian@gmail.com>
Subject: git status and diff-files don't agree on unmerged file
Date: Tue, 2 Mar 2010 22:53:50 -0500
Message-ID: <76718491003021953l7c982c70vd2e9f082f1762fea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 03 04:53:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmfem-00011d-M5
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 04:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab0CCDxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 22:53:51 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:63474 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab0CCDxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 22:53:51 -0500
Received: by iwn34 with SMTP id 34so957097iwn.15
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 19:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=JknRB4Jz6f2nE/xY5KkrZWVwKXp9xkdO95yJAGkbry4=;
        b=lNK45K97buCCkpZOebhdtBz2IwMZxgMbZmjU5CQ/oHegWANkaL6JDHLNf/QSaseDyK
         OscUvKH5y7tF+0irNwXmmQ3TDn8W3GlgZ0Afo1WCtMgwgsHgbD0feK23issNvfkAmQ/U
         i9crm1GJwyI/0Z3YzigkHObU71nzKbur8fhJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=C5PPueRvJC3MpBV3A25CDmk6Wx+xrRuMJtRrEPBmN2wnjA+10b+BQ0W8uSdJfeFrLZ
         4tpH9nLYXIhSv71t+HbgodWM/Q6iZZU/XGh3j6OioRPC82ky3KLlkbqlZL1Yl4XAimCy
         lf1xyiHwI+Sg3ZX0aPb/VPqV0F745hBKdprI0=
Received: by 10.231.159.207 with SMTP id k15mr514431ibx.75.1267588430269; Tue, 
	02 Mar 2010 19:53:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141433>

I've run into an issue recently where I'll be rebasing, hit a
conflict, resolve it, use "git add" (I think...) but rebase doesn't
want to continue. It seems there is a disagreement between diff-files
and status while in this state:

$ git --version
git version 1.7.0.1.242.ga1f88

$ git status
# Not currently on any branch.
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   chrome/browser/cocoa/browser_window_controller.mm
#	modified:   chrome/browser/cocoa/tab_strip_controller.h
#	modified:   chrome/browser/cocoa/tab_strip_controller.mm
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	.mailmap

$ git diff-files --ignore-submodules
:100644 100644 b6ac7eb5e74d21eb7d5806f05a2ed83d6078ced3
0000000000000000000000000000000000000000
M	chrome/browser/cocoa/tab_strip_controller.h

git add on the file in question resolves the problem, but shouldn't
said file show up as "unmerged" in the output of git status?

j.
