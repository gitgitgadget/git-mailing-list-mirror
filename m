From: madmarcos <fru574@my.utsa.edu>
Subject: Re: Java Inflater problem decompressing packfile
Date: Sat, 16 Apr 2011 07:58:19 -0700 (PDT)
Message-ID: <1302965899845-6279085.post@n2.nabble.com>
References: <1302919505984-6278154.post@n2.nabble.com> <20110416063729.GC28853@sigill.intra.peff.net> <1302963832717-6279028.post@n2.nabble.com> <1302964576373-6279050.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 16:58:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB6xB-0002SS-2s
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 16:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069Ab1DPO6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 10:58:22 -0400
Received: from sam.nabble.com ([216.139.236.26]:60002 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811Ab1DPO6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 10:58:20 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <fru574@my.utsa.edu>)
	id 1QB6x1-0007cl-Re
	for git@vger.kernel.org; Sat, 16 Apr 2011 07:58:19 -0700
In-Reply-To: <1302964576373-6279050.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171673>

here is some code that shows the problem. sorry if the formatting fails. not
sure if I am supposed to use code tags or something.


		try {
			byte[] packFile = readFile("/Users/marcos/GitProxyCache/jedit.pack");
			
			//THE BELOW OBJECT DECOMPRESSES FINE
       		//Object starts at index 8616
       		//Type = 3, Decompressed size = 2248 (uses 2 extra size bytes)
			//byte [] packDataWindow = new byte[8000];
			//System.arraycopy(packFile, 8619, packDataWindow, 0,
packDataWindow.length); //works
			
			//THE BELOW OBJECT FAILS TO INFLATE
			//IT CAUSES an "incorrect data check" error
       		//Object starts at index 9470
       		//Type = 3, Decompressed size = 51060 (uses 2 extra size bytes)
			byte [] packDataWindow = new byte[8000];
			System.arraycopy(packFile, 9473, packDataWindow, 0,
packDataWindow.length); //does not work

			Inflater decompresser = new Inflater();
			decompresser.setInput(packDataWindow, 0, packDataWindow.length);
			byte[] result = new byte[60000];
			int resultLength = 0;
			resultLength = decompresser.inflate(result);
			String outputString = new String(result, 0, resultLength, "UTF-8");
			System.out.println(outputString);
			decompresser.end();
		} catch (Exception e) {
			e.printStackTrace();
		}


--
View this message in context: http://git.661346.n2.nabble.com/Java-Inflater-problem-decompressing-packfile-tp6278154p6279085.html
Sent from the git mailing list archive at Nabble.com.
