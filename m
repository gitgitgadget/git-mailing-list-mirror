From: duchier@ps.uni-sb.de
Subject: Re: [ANNOUNCEMENT] /Arch/ embraces `git'
Date: Wed, 20 Apr 2005 19:15:55 +0200
Message-ID: <877jixfjxw.fsf@star.lifl.fr>
References: <200504201000.DAA04988@emf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gnu-arch-users@gnu.org, gnu-arch-dev@lists.seyza.com, talli@museatech.net,
	git@vger.kernel.org, torvalds@osdi.org
X-From: gnu-arch-dev-bounces@lists.seyza.com Wed Apr 20 19:13:41 2005
Return-path: <gnu-arch-dev-bounces@lists.seyza.com>
Received: from [207.166.200.220] (helo=hera.museatech.net)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1DOIlE-0002rC-E6
	for gcvad-gnu-arch-dev@gmane.org; Wed, 20 Apr 2005 19:13:12 +0200
Received: (qmail 13637 invoked by uid 110); 20 Apr 2005 17:17:27 -0000
Received: from gnu-arch-dev-bounces@lists.seyza.com by hera by uid 102 with qmail-scanner-1.20 
 (clamscan: 0.60. spamassassin: 2.60.  Clear:RC:1(127.0.0.1):. 
 Processed in 0.071934 secs); 20 Apr 2005 17:17:27 -0000
Received: from unknown (HELO hera.museatech.net) (127.0.0.1)
  by hera.museatech.net with SMTP; 20 Apr 2005 17:17:26 -0000
Delivered-To: list-gnu-arch-dev@lists.seyza.com
Received: (qmail 13593 invoked by uid 110); 20 Apr 2005 17:17:22 -0000
Received: from duchier@ps.uni-sb.de by hera by uid 102 with qmail-scanner-1.20
	(clamscan: 0.60. spamassassin: 2.60.  Clear:RC:1(207.166.200.201):. 
	Processed in 0.086183 secs); 20 Apr 2005 17:17:22 -0000
Received: from unknown (HELO a1.mx.alal.us) (207.166.200.201)
	by hera.museatech.net with SMTP; 20 Apr 2005 17:17:21 -0000
Received: (qmail 28297 invoked from network); 20 Apr 2005 18:31:32 -0000
Received: from reserv5.univ-lille1.fr (193.49.225.19)
	by a1.mx.alal.us with SMTP; 20 Apr 2005 18:31:30 -0000
Received: from malonne.lifl.fr (malonne.lifl.fr [134.206.10.29])
	by reserv5.univ-lille1.fr (8.13.3/jtpda-5.3.1) with ESMTP id
	j3KHFsDH005861 ; Wed, 20 Apr 2005 19:15:55 +0200
Received: from star.lifl.fr (star.lifl.fr [134.206.10.23])
	by malonne.lifl.fr  with ESMTP id j3KHFt628989
	; Wed, 20 Apr 2005 19:15:56 +0200 (MEST)
To: Tom Lord <lord@emf.net>
In-Reply-To: <200504201000.DAA04988@emf.net> (Tom Lord's message of "Wed, 20
	Apr 2005 03:00:36 -0700 (PDT)")
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: duchier@ps.uni-sb.de
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on dev.alal.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=9.0 tests=BAYES_00,NO_REAL_NAME 
	autolearn=no version=3.0.2
X-BeenThere: gnu-arch-dev@lists.seyza.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: a mailing list for GNU Arch developers <gnu-arch-dev.lists.seyza.com>
List-Unsubscribe: <http://lists.seyza.com/cgi-bin/mailman/listinfo/gnu-arch-dev>, 
	<mailto:gnu-arch-dev-request@lists.seyza.com?subject=unsubscribe>
List-Archive: <http://lists.seyza.com/pipermail/gnu-arch-dev>
List-Post: <mailto:gnu-arch-dev@lists.seyza.com>
List-Help: <mailto:gnu-arch-dev-request@lists.seyza.com?subject=help>
List-Subscribe: <http://lists.seyza.com/cgi-bin/mailman/listinfo/gnu-arch-dev>, 
	<mailto:gnu-arch-dev-request@lists.seyza.com?subject=subscribe>
Sender: gnu-arch-dev-bounces@lists.seyza.com
Errors-To: gnu-arch-dev-bounces@lists.seyza.com
X-Broken-Reverse-DNS: no host name found for IP address 207.166.200.220

Hi Tom,

just as a datapoint, here is an experiment I carried out.  I wanted to evaluate
how much overhead is incurred by using several levels of directories to
implement a discrimating index.  I used the key format you specified:

	SHA1,SIZE

As data, I used my /usr/src/linux which uses 301M and contains 20753 files and
1389 directories.  To compute the key for a directory, I considered that its
contents were a mapping from names to keys.

When constructing the indexed archive, I actually stored empty files instead of
blobs because I am only interested in overhead.

Using your suggested indexing method that uses [0:4] as the 1st level key and
[4:8] as the 2nd level key, I obtain an indexed archive that occupies 159M,
where the top level contains 18665 1st level keys, the largest first level dir
contains 5 entries, and all 2nd level dirs contain exactly 1 entry.

Using Linus suggested 1 level [0:2] indexing, I obtain an indexed archive that
occupies 1.8M, where the top level contains 256 1st level keys, and where the
largest 1st level dir contains 110 entries.

This experiment was performed on an ext3 file system.

Cheers,

--Denys
