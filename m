From: dhruva <dhruva@ymail.com>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Tue, 16 Sep 2008 08:21:26 +0530 (IST)
Message-ID: <306294.11791.qm@web95003.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, David Brown <git@davidb.org>,
	GIT SCM <git@vger.kernel.org>, Simon Hausmann <simon@lst.de>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 04:53:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfQgq-0006St-LQ
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 04:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbYIPCva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 22:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753827AbYIPCva
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 22:51:30 -0400
Received: from n2a.bullet.in.yahoo.com ([202.43.219.19]:21223 "HELO
	n2a.bullet.in.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753438AbYIPCv3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2008 22:51:29 -0400
Received: from [202.86.4.171] by n2.bullet.in.yahoo.com with NNFMP; 16 Sep 2008 02:51:26 -0000
Received: from [203.104.18.52] by t2.bullet.in.yahoo.com with NNFMP; 16 Sep 2008 02:51:26 -0000
Received: from [127.0.0.1] by omp113.mail.in2.yahoo.com with NNFMP; 16 Sep 2008 02:51:26 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 376370.46905.bm@omp113.mail.in2.yahoo.com
Received: (qmail 11894 invoked by uid 60001); 16 Sep 2008 02:51:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=TWimHZHk5N6cAATGLfeDe3j/aBeSzYohI0fm697K1HFhGguoCLMD7gJO6ppYTenoG0rrdUPqugx5v+u+niZfYID9yNgpMDtslZwoA3rAPQKUQ2zQKG9m6C1GzBdkjgwXDGdSxdOBa36oIhz0A1JSsb3WAGx8ivAK59UPVVlfvHY=;
X-YMail-OSG: lSZl36EVM1n4jjTy2TJfnFhGvtmiuvB1vuHfkh0K.PpxigkO5.GZMoFjsxfhLMmig9hVra.p8ybGZUjRg8K01gsPMmrrPEv0cLUG8rGqHx8hAF7et1NlhU4mzQR01nw-
Received: from [202.3.112.9] by web95003.mail.in2.yahoo.com via HTTP; Tue, 16 Sep 2008 08:21:26 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95967>

Hello,



----- Original Message ----
> On Mon, Sep 15, 2008 at 1:46 PM, dhruva wrote:
> > ----- Original Message ----
> >> From: Tor Arvid Lund 
> ------ >8 ------
> >> Hmm.. I thought this was not a p4 problem. I think however, that
> >> "git-p4 submit" tries to do git format-patch and then git apply that
> >> patch to the p4 directory. In other words, I believe that git apply
> >> fails since the file in the p4 dir has the keywords expanded, while
> >> the patch does not. I haven't done any careful investigation, but If
> >> my assumption is true, it sounds like dhruvas patch should work...
> >
> > Your assumption is true (from my understanding of the code). My doubt is, even 
> the files in p4 folder will be from git with no RCS keyword expanded. The patch 
> application must ideally be clean! I am confused here.
> 
> Hmm, regarding the p4 folder - I'm pretty sure git-p4 calls "p4 sync
> /..." in that folder before applying the patch. So those
> files are whatever p4 says they are - which is with keywords
> expanded...

I went through the script more closely, you are correct in your analysis. There is a call to 'p4 sync' (around line 797) before applying the commit patches (around line 809). Hence, the current patch would fix this problem of missing hunks with RCS keywords. The other approach of overwriting instead of applying the patch would also work but I feel that is a bit dangerous. It is better to fail if something goes minutely wrong than submit the wrong file (just being a paranoid defensive programmer).

-dhruva



      Get an email ID as yourname@ymail.com or yourname@rocketmail.com. Click here http://in.promos.yahoo.com/address
