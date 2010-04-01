From: jussi.sirpoma@sks.fi
Subject: Re: Dealing with mac linefeeds in git repository
Date: Thu, 1 Apr 2010 16:19:05 +0300
Message-ID: <OF04EBFCA7.AEB239AD-ONC22576F8.003BC70A-C22576F8.0049585D@sks.fi>
References: <OF7E748769.D4E7BC90-ONC22576F7.00483B3D-C22576F7.00484D0A@sks.fi> <20100331141608.GA2542@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Apr 01 15:27:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxKQm-00037z-TL
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 15:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987Ab0DAN1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 09:27:22 -0400
Received: from sksci1.sks.fi ([193.208.185.25]:51743 "EHLO msg.sks.fi"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750867Ab0DAN1U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 09:27:20 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Apr 2010 09:27:19 EDT
Received: from sksinfo.sks.fi ([10.1.2.231])
	by msg.sks.fi (8.14.3/8.14.3) with ESMTP id o31ExjfH015089;
	Thu, 1 Apr 2010 17:59:46 +0300
In-Reply-To: <20100331141608.GA2542@LK-Perkele-V2.elisa-laajakaista.fi>
X-KeepSent: 04EBFCA7:AEB239AD-C22576F8:003BC70A;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.0.2 August 07, 2008
X-MIMETrack: Serialize by Router on srvdomino1/SKS(Release 8.0.2FP1|January 12, 2009) at
 01.04.2010 16:19:05,
	Serialize complete at 01.04.2010 16:19:05
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166
 definitions=2010-04-01_09:2010-02-06,2010-04-01,2010-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 engine=5.0.0-0908210000 definitions=main-1004010098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143729>

Thank you Ilari,

The filter approach seems to work nicely.

git config --global filter.maclinefeed.smudge 'tr \\n \\r'
git config --global filter.maclinefeed.clean 'tr \\r \\n'

With suitable filter and -crlf settings in .gitattributes,

- Jussi Sirpoma



From:
Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To:
jussi.sirpoma@sks.fi
Cc:
git@vger.kernel.org
Date:
31.03.2010 17:14
Subject:
Re: Dealing with mac linefeeds in git repository
Sent by:
git-owner@vger.kernel.org



On Wed, Mar 31, 2010 at 04:07:40PM +0300, jussi.sirpoma@sks.fi wrote:
> I am running cygwin git version 1.6.4.2.
> 
> Some of the source code for our projects is encoded in mac linefeeds due 

> to proprietary
> software platform. My current solution is to flag those files tu use no 
> linefeed conversion and
> to use separate diff program by having this in .gitattributes:

> annotations or diffs. Now I am wondering if I could make git work with a 

> little different 
> configuration:
> 
> * The *.BA files with mac linefeeds would be stored with normal linux 
> linefeeds
> * The files would be converted on checkout to mac linefeeds the same way 

> as core.autcrlf works
> 
> Is this doable or even a good approach?
 
AFAIK, its doable. One can specify filter programs to be executed when
checking out / adding files. That program could do CR <-> LF translation.

See filter attribute in man gitattributes.

-Ilari
