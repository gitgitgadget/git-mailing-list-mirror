From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Sun, 04 May 2014 08:07:26 +0200
Message-ID: <5365D91E.70207@alum.mit.edu>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net> <1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 08:07:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgpaN-0006R4-0n
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 08:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbaEDGHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 02:07:30 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:64481 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751390AbaEDGH3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2014 02:07:29 -0400
X-AuditID: 12074413-f79076d000002d17-19-5365d920f84c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 16.3F.11543.029D5635; Sun,  4 May 2014 02:07:28 -0400 (EDT)
Received: from [192.168.69.130] (p4FC963E8.dip0.t-ipconnect.de [79.201.99.232])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4467QTh020489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 4 May 2014 02:07:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsUixO6iqKtwMzXY4MpyeYuuK91MFm0zfzA5
	MHksv/mXyePzJrkApihum6TEkrLgzPQ8fbsE7oxrl/+wFNzhqDj+7QhTA2MrexcjJ4eEgInE
	1WczmCFsMYkL99azdTFycQgJXGaUOH9lAROEc45JYtbPfrAqXgFNiRs7DzOC2CwCqhJ/TrwB
	m8QmoCuxqKcZqIGDQ1QgSOLPWUWIckGJkzOfsIDYIgJeEvMfzWAFsYUFrCV2Nr9ghJjfzyjR
	secv2HxOAT+Jo+sa2UDmSAiIS/Q0BoGEmQV0JN71PWCGsOUltr+dwzyBUWAWkhWzkJTNQlK2
	gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuuV5uZoleakrpJkZIoArvYNx1Uu4QowAHoxIP
	74lbycFCrIllxZW5hxglOZiURHk7dqYGC/El5adUZiQWZ8QXleakFh9ilOBgVhLhvb4HKMeb
	klhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuCVvQHUKFiUmp5akZaZU4KQ
	ZuLgBBnOJSVSnJqXklqUWFqSEQ+K1PhiYKyCpHiA9mqDtPMWFyTmAkUhWk8x6nJcaFjRwiTE
	kpeflyolzutzHahIAKQoozQPbgUsLb1iFAf6WJjXBmQUDzClwU16BbSECWiJuGMyyJKSRISU
	VAOj/K+SxmXLs/Z39D6Yf6HzwbcF/5+sKSit1M6Rvxkm6lm0+PS07UrGD8xNGlz/NRT4fdU9
	wz7R8aPg8Us+gRbszc+s5+l/dPCZ07dw6tRr2w19dqqv2ntLJfsFa5aNW/3vUF5Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248072>

On 05/03/2014 10:12 PM, brian m. carlson wrote:
> Many places throughout the code use "unsigned char [20]" to store object IDs
> (SHA-1 values).  This leads to lots of hardcoded numbers throughout the
> codebase.  It also leads to confusion about the purposes of a buffer.
> 
> Introduce a structure for object IDs.  This allows us to obtain the benefits
> of compile-time checking for misuse.  The structure is expected to remain
> the same size and have the same alignment requirements on all known
> platforms, compared to the array of unsigned char.

Please clarify whether you plan to rely on all platforms having "the
same size and alignment constraints" for correctness, or whether that
observation of the status quo is only meant to reassure us that this
change won't cause memory to be wasted on padding.

If the former then I would feel very uncomfortable about the change.
Otherwise I think it will be a nice improvement in code clarity (and I
admire your ambition in taking on this project!)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
