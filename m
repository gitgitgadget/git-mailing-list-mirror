From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Subject: Re: Query: Patches break with Microsoft exchange server.
Date: Wed, 11 Aug 2010 11:16:50 -0500
Message-ID: <4C62CCF2.5040206@mnsu.edu>
References: <4C5F9B25.8080401@st.com>	 <AANLkTinxwRFLUibJECm0c3_oL5mYRkmscsw-xXgAHSTe@mail.gmail.com>	 <4C624AE1.30504@st.com>  <4C62C5BD.3020808@mnsu.edu> <1281542305.5107.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: viresh kumar <viresh.kumar@st.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" 
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Justin P. Mattock" <justinmattock@gmail.com>,
	=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
	<u.kleine-koenig@pengutronix.de>,
	Valeo de Vries <valeo@valeo.co.cc>,
	Linus Walleij <linus.ml.walleij@gmail.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>, mihai.dontu@gmail.com,
	richardcochran@gmail.com, "Gadiyar, Anand" <gadiyar@ti.com>
To: David Woodhouse <dwmw2@infradead.org>
X-From: linux-kernel-owner@vger.kernel.org Wed Aug 11 18:17:37 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1OjDze-000864-PU
	for glk-linux-kernel-3@lo.gmane.org; Wed, 11 Aug 2010 18:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636Ab0HKQRV (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 11 Aug 2010 12:17:21 -0400
Received: from Mail.MNSU.EDU ([134.29.1.12]:40277 "EHLO mail.mnsu.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221Ab0HKQRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2010 12:17:20 -0400
Received: from [134.29.32.1] (j3gum-3.ITS.MNSU.EDU [134.29.32.1])
	by mail.mnsu.edu (8.13.7/8.13.7) with ESMTP id o7BGGoUC005706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Aug 2010 11:16:50 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100805 Icedove/3.0.6
In-Reply-To: <1281542305.5107.11.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153262>

On 08/11/2010 10:58 AM, David Woodhouse wrote:
 > On Wed, 2010-08-11 at 10:46 -0500, Jeffrey Hundstad wrote:
 >> Exchange 2010 does not handle IMAP "chunking" (partial message transfer)
 >> correctly.  Any request after about 1 megabyte of total message size
 >> will fail.
 >>
 >> Thunderbird uses this "chunking" feature to give you a status update
 >> while downloading large messages.  The IMAP statements are of this type:
 >> 11 UID fetch 244477 (UID RFC822.SIZE BODY[]<20480.12288>)
 >>
 >> When the 20480 is larger than 1MB Exchange "claims" there is no more.
 >> Sigh....
 >
 > I think the problem is not with the fetching -- the problem is that
 > Exchange lies about RFC822.SIZE before the IMAP client even starts to
 > fetch the message. It reports a size which is smaller than the actual
 > size of the message, thus leading to truncated fetches.
 >
 > In Evolution we have a workaround -- we don't just stop when we get to
 > the reported RFC822.SIZE; we continue fetching more chunks until the
 > server actually stops giving us any more. It's not as efficient (because
 > we fall back to having only one more chunk outstanding at a time rather
 > than the normal three in parallel), but at least it works around this
 > brokenness of Exchange.
 >
 > http://git.gnome.org/browse/evolution-data-server/commit/?id=9714c064
 >

In either case it can be used successfully by disabling 
mail.server.default.fetch_by_chunks in Thunderbird.

-- 
Jeffrey Hundstad
