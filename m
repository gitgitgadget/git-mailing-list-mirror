From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-blame: Make the output human readable
Date: Sun, 5 Mar 2006 15:23:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603051516020.12866@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060305110351.GA23448@c165.ib.student.liu.se>
 <7vbqwlgkhk.fsf@assigned-by-dhcp.cox.net> <20060305123800.GD23448@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 15:23:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFu8l-0005n7-Bz
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 15:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWCEOXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 09:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWCEOXJ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 09:23:09 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:58511 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932133AbWCEOXI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 09:23:08 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 1B27D1CA3;
	Sun,  5 Mar 2006 15:23:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 0EB131143;
	Sun,  5 Mar 2006 15:23:05 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id D946620B7;
	Sun,  5 Mar 2006 15:23:04 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060305123800.GD23448@c165.ib.student.liu.se>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17231>

Hi,

On Sun, 5 Mar 2006, Fredrik Kuivinen wrote:

> On Sun, Mar 05, 2006 at 04:10:47AM -0800, Junio C Hamano wrote:
> > Fredrik Kuivinen <freku045@student.liu.se> writes:
> > 
> > > +git-blame$X: blame.o $(LIB_FILE)
> > > +	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> > > +		$(LIBS) -lm
> > > +
> > 
> > I wonder what it is about to link this binary different from others...
> > 
> 
> It uses log(3) to compute the number of digits needed to represent the
> last line number. It is probably better to this some other way
> though...

How about this:

-	max_digits = 1 + log(num_blame_lines+1)/log(10);
+	for (i = 10, max_digits = 1; i <= num_blame_lines + 1;
+		i *= 10, max_digits++);

(Totally untested)

Hth,
Dscho
