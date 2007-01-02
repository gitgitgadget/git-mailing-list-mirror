From: "Nicholas Miell" <nmiell@gmail.com>
Subject: infinite loop with git branch -D and packed-refs
Date: Mon, 1 Jan 2007 22:44:01 -0800
Message-ID: <b566b20c0701012244l21f85472k83970c0c573ce105@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 02 07:44:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1dNg-0008Uz-D7
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 07:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280AbXABGoG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 01:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755284AbXABGoG
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 01:44:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:64184 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280AbXABGoD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 01:44:03 -0500
Received: by nf-out-0910.google.com with SMTP id o25so7222908nfa
        for <git@vger.kernel.org>; Mon, 01 Jan 2007 22:44:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UkRpNBLec8PEql66ZmP1O7uLoHI+HiDe+yucTp7pZLCToX4XBw397/dfDaf3arW0X1+K0jVst6Uwva9cW32iA25ElwpzN6rJhdDi0bBOA7R6q6COHnDy8G7JJogQueP7X88i1MISAZAx+DzujiifdNHk+22PkK9vSKD4vBgu+F8=
Received: by 10.82.114.3 with SMTP id m3mr1479863buc.1167720242082;
        Mon, 01 Jan 2007 22:44:02 -0800 (PST)
Received: by 10.82.159.1 with HTTP; Mon, 1 Jan 2007 22:44:01 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35774>

# this is with 1.4.4.2, spearce says master is also affected.
# (not subscribed, please Cc:)

mkdir test
cd test
git init-db
touch blah
git add blah
git commit -m "blah"
git checkout -b A
git checkout -b B
git checkout master
git pack-refs --all --prune
git branch -D A B # --> infinite loop in lockfile.c:remove_lock_file()
