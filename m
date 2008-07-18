From: =?ISO-8859-1?Q?Florian_K=F6berle?= <FloriansKarten@web.de>
Subject: Re: [JGIT PATCH 17/28] Support automatic command line parsing for
 TextBuiltin subclasses
Date: Fri, 18 Jul 2008 21:01:20 +0200
Message-ID: <4880E880.1010403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 21:03:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJvEn-0006wg-9l
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 21:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807AbYGRTC3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2008 15:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756012AbYGRTC3
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 15:02:29 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:50842 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755774AbYGRTC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 15:02:29 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 70A38E65495B;
	Fri, 18 Jul 2008 21:01:18 +0200 (CEST)
Received: from [84.150.68.42] (helo=[192.168.1.50])
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1KJvCg-00030p-00; Fri, 18 Jul 2008 21:01:18 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
X-Enigmail-Version: 0.95.6
X-Sender: FloriansKarten@web.de
X-Provags-ID: V01U2FsdGVkX19ri1mPgGpdr39P3yPYqY18bTG16h9MlFmLMrhx
	TwGDbT0Vy9EMY992rCc+Xw5K0cKcrXWoagH+12DIhu4qbo35EG
	xnFxV8T2iT05zpowNy3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89074>

Hi Shawn

to use args4j was really a great idea. I had a patch, implementing
something similar to args4j in my repository, but using a library is
always better. *thumb up*


I had a short look at the files and noticed that the inner "if (help) {=
"
is unnecessary:

+		if (help) {
+			System.err.print("jgit ");
+			System.err.print(commandName);
+			clp.printSingleLineUsage(System.err);
+			System.err.println();
+
+			if (help) {
+				System.err.println();
+				clp.printUsage(System.err);
+				System.err.println();
+			}
+			System.exit(1);
+		}

Also a cool function which you may want to use is:

public <U> Class<? extends U> asSubclass(Class<U> clazz)

With that method of Class<?> you can do the cast before you actually
create the object.
You could for example make use of them in SubcommandHandler:
l. 124			cmd =3D (TextBuiltin) cons.newInstance();

Best regards,
=46lorian K=F6berle
