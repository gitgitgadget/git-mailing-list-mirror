From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from
 remote remote"
Date: Sun, 15 Apr 2012 13:45:18 +0200
Message-ID: <20120415114518.GB9338@ecki>
References: <4F893CD8.5020700@gmail.com>
 <20120414201446.GB29999@ecki>
 <4F8A0F96.5060408@gmail.com>
 <20120415011118.GA4123@ecki>
 <4F8A8211.2010908@gmail.com>
 <20120415105943.GD6263@ecki>
 <4F8AAE7C.1020507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 13:47:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJNv9-0003Ag-Um
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 13:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327Ab2DOLqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 07:46:37 -0400
Received: from smtpout16.highway.telekom.at ([195.3.96.93]:25331 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751231Ab2DOLqg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 07:46:36 -0400
Received: (qmail 21241 invoked from network); 15 Apr 2012 11:46:32 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL505.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub78.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <stefano.lattarini@gmail.com>; 15 Apr 2012 11:46:32 -0000
Content-Disposition: inline
In-Reply-To: <4F8AAE7C.1020507@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195561>

Hi Stefano,

Almost there. :-)

On Sun, Apr 15, 2012 at 01:18:20PM +0200, Stefano Lattarini wrote:
> 
> $ git 'fast-export' '--use-done-feature' \
>       '--export-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
>       '--import-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
>       '^refs/testgit/origin/master' 'refs/heads/master' \
>    | git 'fast-import' \
>          '--export-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks' \
>          '--import-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks'

To simulate a git push, you have to run fast-export from localclone and
fast-import from the server directory. I.e. starting out in
t/trash directory.t5800-remote-helpers:

$ (cd localclone; git fast-export --use-done-feature \
      --export-marks='.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
      --import-marks='.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
      ^refs/testgit/origin/master refs/heads/master) |
  (cd server; git fast-import \
         --export-marks='/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks' \
         --import-marks='/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks')
