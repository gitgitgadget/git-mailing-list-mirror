From: "nathan bullock" <nathanbullock@gmail.com>
Subject: Splitting code between files and then merging
Date: Mon, 14 Apr 2008 19:22:34 -0600
Message-ID: <916b88c10804141822m45588ae9x7492867b749cc53c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 03:24:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlZtv-0005vQ-R0
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 03:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855AbYDOBWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 21:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756043AbYDOBWq
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 21:22:46 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:56894 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763AbYDOBWq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 21:22:46 -0400
Received: by yw-out-2324.google.com with SMTP id 5so849521ywb.1
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 18:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=QL2Wahd4m9Z70DKGVjhfbaSEQ8J8ID2wHo/MOcA3uos=;
        b=SvPGHRo2wgFhfjXILI/k8Nbdy9sQgdHrKFtm7ViI9zn6htvHTck1jhILFpmCjIyt49MEMlIqGLlnE8E0FdPiQrmgAuPcuUqgwlYaOW6E2CNoCXDwUqn5YF4VsFsbLgb+hI/7TtApxbUnwm7Lo+qiz0vKsq3TmwJtbfZXBPsq200=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JVvCgFS/7Zt0joVBq5TJTxrTMreenbf84TohD4ipM2uU9pIJC1C5KgXLjGmr7onfYk3Uw0Rr6cVWUt6vdx7VfZASlgDnhLGlJfHNyIsxWD6euKdHU6yv+HBCW1TKNcaP03HoWrPPyVtGNdwSp8yeNCO/WK9kUZV8+rwrHPhAOdg=
Received: by 10.150.123.16 with SMTP id v16mr7038911ybc.76.1208222554946;
        Mon, 14 Apr 2008 18:22:34 -0700 (PDT)
Received: by 10.150.149.3 with HTTP; Mon, 14 Apr 2008 18:22:34 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79553>

I have been playing around with various merge situations and things
don't seem to be working quite as I expected.

If I have a repository with a file such as:

### file abc ###
void
foo(){
  int x;
  func(x);
}

void
moo(){
  int y;
  func(y);
}

And then clone that repo and in my clone I edit things so that I have two files:

### file abc ###
void
foo(){
  int x;
  func(x);
}

### file bcd ###
void
moo(){
  int y;
  func(y);
}

I commit this.

Then I do a git blame -C -C6 bcd
(If I make these functions larger I can get away with just a single -C)

It seems to be able to determine that all of the lines in both files
originated from the file abc.

Now the problem is that if I make a change to the function moo in the
file abc in the original repo and the try to pull it into the second
repo I always get merge conflicts. Is this expected? Do any of the
various merge algorithms in git handle these situations?

Nathan Bullock
