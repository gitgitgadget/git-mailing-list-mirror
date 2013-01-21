From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [RFC] git rm -u
Date: Mon, 21 Jan 2013 20:10:14 +0100
Message-ID: <CAA01Csp3S17+RyD15mRwfzbY2TTf27m14dpS7CkL5KSg6cWStg@mail.gmail.com>
References: <50FB1196.2090309@gmail.com>
	<20130119214921.GE4009@elie.Belkin>
	<vpq622s9jk1.fsf@grenoble-inp.fr>
	<7v1udfn0tm.fsf@alter.siamese.dyndns.org>
	<CAA01Csrv26WrrJDAo-1cr+rW6rYFGQZpYgtafEh=Wgtzswdv_g@mail.gmail.com>
	<7v622qhouc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:10:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxMlU-0000E4-BC
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab3AUTKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 14:10:16 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:46129 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab3AUTKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 14:10:15 -0500
Received: by mail-qc0-f170.google.com with SMTP id d42so2631625qca.1
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 11:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Ij5A60deKHZnPavM8dF+IWr7diskfWbEd1LgWI3Gj9Q=;
        b=E3DCuJb21UbA5y5ad5RP7pVxYSvMrxJqDz/PEBh0tv5yEZYe64bTpn75FEWBkzTm8B
         GiUsbh8Lyh+uGO3W3dt5EJ0fskd5JlrBlkAmEB6Q2SMR3bqp3GbeQFFYKmzuxhlxgHZZ
         vMWrHe87e9ssrqRCrKlu9Oc08pXDn49jlkaRAIbWZKGX0aexrrXRKE9Mgl1RbhwrG2FL
         uDviLx1teZwGrpKUSi/nVG+9t29uem1JeJYlDyr/xyj50RyffDHObXZ8Svj9iVrAn8/A
         pSM6doJ71UnG6F9fr2FCWUqMXDehu/5sNxbtAPP50uyO9PZijajaDHNN4JIE8r/npWKC
         sxgw==
X-Received: by 10.49.130.167 with SMTP id of7mr23642171qeb.22.1358795414312;
 Mon, 21 Jan 2013 11:10:14 -0800 (PST)
Received: by 10.49.84.133 with HTTP; Mon, 21 Jan 2013 11:10:14 -0800 (PST)
In-Reply-To: <7v622qhouc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214143>

On Mon, Jan 21, 2013 at 10:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> No.  This is only about "git add -u<RETURN>", not any other forms of
> "git add ...with or without other args...".
>
> "git add -u<RETURN>" historically meant, and it still means, to
> "update the index with every change in the working tree", even when
> you are in a subdirectory.

But it *currently* limits itself to a subdirectory - does not work on
whole tree:

piotr@PIOTR-X73 ~/dv/test/dir1 (master)
$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   dir2/file2.txt
#       modified:   file1.txt
#       modified:   ../file.txt
#
no changes added to commit (use "git add" and/or "git commit -a")

piotr@PIOTR-X73 ~/dv/test/dir1 (master)
$ git add -u

piotr@PIOTR-X73 ~/dv/test/dir1 (master)
$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   dir2/file2.txt
#       modified:   file1.txt
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   ../file.txt
#

piotr@PIOTR-X73 ~/dv/test/dir1 (master)
$ git --version
git version 1.8.0.msysgit.0



--
Piotr Krukowiecki
