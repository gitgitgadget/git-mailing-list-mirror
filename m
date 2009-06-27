From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 7/8] gitweb: recognize 'trivial' acks
Date: Fri, 26 Jun 2009 18:03:05 -0700
Message-ID: <7vr5x6mqt2.fsf@alter.siamese.dyndns.org>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com>
	<1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
	<1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com>
	<1245926587-25074-5-git-send-email-giuseppe.bilotta@gmail.com>
	<1245926587-25074-6-git-send-email-giuseppe.bilotta@gmail.com>
	<1245926587-25074-7-git-send-email-giuseppe.bilotta@gmail.com>
	<1245926587-25074-8-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 03:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKMKC-0001tF-IP
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 03:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbZF0BDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 21:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbZF0BDE
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 21:03:04 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:45629 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbZF0BDE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 21:03:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090627010306.XLVG2915.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jun 2009 21:03:06 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8p351c00E4aMwMQ03p35rd; Fri, 26 Jun 2009 21:03:06 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=cgYsbkzc-XAA:10 a=pGLkceISAAAA:8
 a=DOeTlfXBUC5ymz3az2UA:9 a=060YTzbtMQZqEUera065cMRFiXoA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1245926587-25074-8-git-send-email-giuseppe.bilotta@gmail.com> (Giuseppe Bilotta's message of "Thu\, 25 Jun 2009 12\:43\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122345>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

>  	foreach my $line (@$log) {
> -		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
> +		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|(?:trivially[ \-])?acked[ \-]by[ :]|cc[ :])/i) {

Wouldn't it make more sense to do something like:

	if ($line =~ m/^[-a-z]+: (.*)$/i && looks_like_a_name_and_email($1)) {
            	... do the avatar thing ...
	}

and limit this processing only to the last run of no-blank lines?
