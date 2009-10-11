From: Bruce Korb <bkorb@gnu.org>
Subject: ident pattern match is incorrect
Date: Sun, 11 Oct 2009 09:52:11 -0700
Message-ID: <668c430c0910110952p3abe2d1cl82c2d979f12e5a2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Bruce Korb <bkorb@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 18:58:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx1kn-00025O-7w
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 18:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575AbZJKQws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 12:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756167AbZJKQws
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 12:52:48 -0400
Received: from mail-gx0-f212.google.com ([209.85.217.212]:52608 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140AbZJKQwr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 12:52:47 -0400
Received: by gxk4 with SMTP id 4so9392984gxk.8
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=jRpxyTj8x+8YkbL2LgOlDiCODgNpSW59+wx2zDPD148=;
        b=dN9F3U3MnrTGAs1427QFO/hytaM+paUYJsmJQeVfV/rYYyR8n48OG8YoUPJhQfXVyn
         kbpTIyvbgtYm7L3qPXe370u1PGpVr0P9LB9/toShJ30WcSrhR32xRJiLshxG5mYPQh+g
         whYDMfZWgP3/NiVpu2k7CO3z4TH4gacjM6TmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        b=IlJmSq5M13y33iMUzhYolaKA9P/1nJ3d3jjvJfTA9YxZMqae2zL2XtUD8mujDXw7W0
         JOZ2R804wIiKe/We9gnbUZMm8bR6qywFxmDP2dbLYCMzLNueNK0WDzVDugPjibUorBqL
         WNSgrXr+tK7QBPUEnQZY+VJ3+uwvs372Y17NE=
Received: by 10.101.56.11 with SMTP id i11mr4847297ank.5.1255279931100; Sun, 
	11 Oct 2009 09:52:11 -0700 (PDT)
X-Google-Sender-Auth: 2ed391cc1344e010
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129938>

The git attribute "ident" fails here:

  sed '2,/and the template file/d
      /\$Id:/d
      /Last template edit:/d' getopt-test_${testname}.c

The pattern match for ident should be (shell syntax):

   $'\$Id(:[^$\n]+\$|\$)'

In other words, it is not a multi-line pattern.
I was looking for a bugzilla entry here:
   http://git-scm.com/

but I did not see a bug reporting method.
