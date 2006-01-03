From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [PATCH] qgit: increase the space between the lanes.
Date: Tue, 03 Jan 2006 23:17:22 +0100
Message-ID: <43BAF7F2.6060906@yahoo.it>
References: <200601031415.19309.matlads@dsmagic.com> <43BA9CFA.8050208@yahoo.it> <200601031949.59822.matlads@dsmagic.com> <200601032007.09081.matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 23:17:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtuTH-0003pL-BV
	for gcvg-git@gmane.org; Tue, 03 Jan 2006 23:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWACWRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jan 2006 17:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWACWRc
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jan 2006 17:17:32 -0500
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:29312 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751483AbWACWRb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2006 17:17:31 -0500
Received: (qmail 94166 invoked from network); 3 Jan 2006 22:17:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=iJxWFjWJVs7KXtjVnJCPTg/XAItyViI9ayKIvqT1Cu1B/J14pn4TPTQjWLZMhy8sc+O4ZoU8wHv7iwPk/g2S30dFK+wpXLouZfGh67VeMKpbyhrrOyLOLZHNtXY7azfTjofaOTHAXi6hU90N8yZtyBk4a+vuc+6pzcT4Wyr938s=  ;
Received: from unknown (HELO ?10.0.0.13?) (mcostalba@151.56.54.71 with plain)
  by smtp102.mail.sc5.yahoo.com with SMTP; 3 Jan 2006 22:17:27 -0000
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: Martin Atukunda <matlads@dsmagic.com>
In-Reply-To: <200601032007.09081.matlads@dsmagic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14161>

Martin Atukunda wrote:
> 
> Hmm, I need to re-think how to do this properly. Any ideas?
> 

Hi Martin,


What about this?

If it is Ok for you I will push the change.



Marco


diff --git a/src/mainimpl.cpp b/src/mainimpl.cpp
index 2f26b01..40a22e8 100644
--- a/src/mainimpl.cpp
+++ b/src/mainimpl.cpp
@@ -1451,7 +1451,7 @@ void MainImpl::setupPixmaps() {
  	// little hack to read items height
  	new QListViewItem(listViewLog);
  	ph = listViewLog->firstChild()->height();
-	pw = ph / 2;
+	pw = 3 * ph / 4;
  	listViewLog->clear(); // remove and deletes items
  	QPixmap cm(pw, ph);
  	cm.fill();
@@ -1470,12 +1470,13 @@ void MainImpl::setupPixmaps() {
  		p.begin(pm);
  		p.setPen(QPen(colors[i % COLORS_NUM], 2));
  		int type = (i / COLORS_NUM) + 1;
+		QBrush myBrush(QBrush(colors[i % COLORS_NUM], Qt::SolidPattern));
  		switch(type) {
  		case ACTIVE:
  			p.drawLine(P_90, P_270);
  			p.save();
  			p.setPen(QPen(colors[i % COLORS_NUM], 1));
-			p.setBrush(QBrush(colors[i % COLORS_NUM], Qt::SolidPattern));
+			p.setBrush(myBrush);
  			p.drawEllipse(pw/8, ph/8, 6*pw/8, 3*ph/8);
  			p.restore();
  			break;
@@ -1485,17 +1486,20 @@ void MainImpl::setupPixmaps() {
  		case MERGE_FORK:
  			p.drawLine(P_90, P_270);
  			p.drawLine(P_180, P_0);
-			p.drawRect(pw/4, ph/4, pw/2, ph/2);
+			p.fillRect (pw/4, ph/4, pw/2, ph/2, myBrush);
+			p.drawRoundRect(pw/4, ph/4, pw/2, ph/2, 25, 25);
  			break;
  		case MERGE_FORK_R:
  			p.drawLine(P_90, P_270);
  			p.drawLine(P_180, P_OR);
-			p.drawRect(pw/4, ph/4, pw/2, ph/2);
+			p.fillRect (pw/4, ph/4, pw/2, ph/2, myBrush);
+			p.drawRoundRect(pw/4, ph/4, pw/2, ph/2, 25, 25);
  			break;
  		case MERGE_FORK_L:
  			p.drawLine(P_90, P_270);
  			p.drawLine(P_OR, P_0);
-			p.drawRect(pw/4, ph/4, pw/2, ph/2);
+			p.fillRect (pw/4, ph/4, pw/2, ph/2, myBrush);
+			p.drawRoundRect(pw/4, ph/4, pw/2, ph/2, 25, 25);
  			break;
  		case JOIN:
  			p.drawLine(P_90, P_270);


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
