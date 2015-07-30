From: Karthik Nayak <karthik.188@gmail.com>
Subject: [GSOC] Update 5: Unification of tag -l, branch -l and for-each-ref
Date: Thu, 30 Jul 2015 21:34:19 +0530
Message-ID: <CAOLa=ZTHe5Tw=CbhBJBeSD0yhwXyG3SOzNxy8zSxtYT+XWFh0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 30 18:04:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKqKD-0007KD-Ur
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 18:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbbG3QEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 12:04:50 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33373 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbbG3QEt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 12:04:49 -0400
Received: by obdeg2 with SMTP id eg2so34197350obd.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=jKCc2sFN0H753k3CFIFOuQ0DYstLcaSAo6wYXJ1GcJM=;
        b=xvZ3m7fevAaKIoYJXzTXjqgGZnBo90KB/8PwzfNR/TE1HwM8gTfyKIRn2Q5PPND20J
         c/l92pO2ArrVT2g4gthajROW7EKu9i65MnWKipDFe3sW4nFuiGJs/gplDc4kSeN/8vK9
         vreHQaBg5XZKQeUADuBp3M6iMUeXhPPbCDL5KseRwXb2rx7S/d6tfDMU2zKrQ8kig3nx
         uS4Ee9Y5TF+ZsyVP6snAyne3RIQA2wPxKflbleoVYa3WvndiE2BeMfIXMDAVZsJzLPv2
         DVJLQKYtHQDCR8MdBveoP3NHuuBtDrLK9mIs3pNs9y+vYXyHvPaOO99biJBSo07MWf1/
         sdNQ==
X-Received: by 10.60.62.105 with SMTP id x9mr45876187oer.1.1438272288894; Thu,
 30 Jul 2015 09:04:48 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Thu, 30 Jul 2015 09:04:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275015>

Hello All,

As part of GSoC I'm working on the Unification of 'for-each-ref', 'tag -l'
and 'branch -l'.

Current Progress:

1. Building ref-filter.{c,h} from for-each-ref.
This is the process of creating an initial library for the unification
by moving most of the code from for-each-ref to ref-filter.{c,h}.
Merged into next

2. Add options to ref-filter.
This includes the porting of --points-at, --contains, --merged,
--no-merged options from builtin/branch.c and builtin/tag.c, Also the
implementation of these options into for-each-ref.
Currently in pu
(https://github.com/git/git/commit/6d4c958d88e6456405b8d65a8bf469382c47f4c5)

3. Port builtin/tag.c to use ref-filter.
Here we port tag.c to use ref-filter and also port the --format,
--sort and --merged and --no-merged options to builtin/tag.c.
Version 7 can be found here :
thread.gmane.org/gmane.comp.version-control.git/274990
We now have support for modifier atoms. Modifier atoms are atoms which
modify succeeding strings or atoms. A simple example of this is the "color"
atom which modifies the color of all succeeding atoms or strings.
Similarly we introduce "padright" atom which will align atoms and strings to the
left followed by spaces. This was after a lot on Input from Junio,
Matthieu, Christian, Duy, Eric and Jacob.
Currently waiting for review from the list.

4. Porting branch.c to use ref-filter.
Here we port branch.c to use ref-filter APIs.
An RFC version was sent to the list and can be found here :
article.gmane.org/gmane.comp.version-control.git/274766
There was a lot of input on this and we are still discussing the structure for
the "ifexists" atom. Currently everyone is indicating towards something like
--format="%(ifexists:<atom>) .............. %(endif).
This seems to be a good design and I hope to implement this over the
next 3 days and send an updated Patch series to the list. Also need to
implement show_ref_array_item() into branch.c. Currently we print form
branch.c itself.

Like always, Thanks to everyone for helping me out, especially my mentors.

All code pushed to github:
Github: https://github.com/KarthikNayak/git

-- 
Regards,
Karthik Nayak
