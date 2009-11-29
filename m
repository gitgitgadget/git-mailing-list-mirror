From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Fwd: What is the best way to backport a feature?
Date: Sun, 29 Nov 2009 19:33:53 +0100
Message-ID: <200911291933.54301.j6t@kdbg.org>
References: <loom.20091129T164518-669@post.gmane.org> <4db3b0200911290941j42c5a0aaq2c6a9836b38066b2@mail.gmail.com> <4db3b0200911290945r34a73346w148ee42e59868876@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Weseloh <peter.weseloh@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 19:34:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEobB-0004vZ-Rk
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 19:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbZK2SeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 13:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbZK2SeF
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 13:34:05 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:46955 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752442AbZK2SeF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 13:34:05 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C8A4DCDF96;
	Sun, 29 Nov 2009 19:34:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 922B019F5F0;
	Sun, 29 Nov 2009 19:33:54 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4db3b0200911290945r34a73346w148ee42e59868876@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134032>

[please keep the Cc list]

On Sonntag, 29. November 2009, Peter Weseloh wrote:
> But on the other hand the intermediate merges from the Mainline make
> for much simpler merges, right?.
> If merging is done only when Feature_A is ready it might become a real
> pain. It might take several month to complete it and the mainline
> might have changed a lot.

Incidentally, Junio has blogged about this just the other day:

http://gitster.livejournal.com/42247.html

Basically, as soon as you merge Mainline into Feature_A, you change the topic 
of Feature_A from "Feature for Release_1.0" to "Feature for this Mainline". 
Clearly, this topic is not suitable for Release_1.0 anymore.

There is a way around this that doesn't sacrifice the topic-oriented nature of 
the branch: You keep developing Feature_A as planned for Release_1.0 and when 
you notice that merging this feature to Mainline will become increasingly 
complex, you fork off a new branch Feature_A_for_Release_2.0 from Mainline 
and merge Feature_A into this new branch:

   o--o--o                    Release_1.0
  /    \  \
 o-o-o--o--o-o-o-o-X-o---o--o Mainline
      \             \
       F1            o--o     Feature_A_for_Release_2.0   
        \           /  /
         F2--------F3-F4      Feature_A

The fork point X must be in Release_2.0.

-- Hannes
