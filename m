From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v3 10/21] pack-bitmap: add support for bitmap indexes
Date: Wed, 27 Nov 2013 10:08:56 +0100
Message-ID: <5295B6A8.70303@gmail.com>
References: <20131114124157.GA23784@sigill.intra.peff.net>	<20131114124432.GJ10757@sigill.intra.peff.net> <87fvqlfpmw.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Vicent_Mart=ED?= <vicent@github.com>
To: Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 27 10:09:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlb7K-0007CR-LY
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 10:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547Ab3K0JJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 04:09:01 -0500
Received: from mail-bk0-f49.google.com ([209.85.214.49]:44535 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab3K0JI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 04:08:57 -0500
Received: by mail-bk0-f49.google.com with SMTP id my13so3039836bkb.36
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 01:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4X2kDOeBlBXMv7g3qHuwYms688i4vJcO8O0RuKd1AQU=;
        b=fLVVTT5UuykbDnYEnUPr3MOgGTjOD8RfagEQZRIlV+JLvnx2aWpLVpIb1kU4Xsd4pw
         LSAOH0MWPoaAIMr8trLxwyysyTHoXK1t0b+H4WaUOb0aXjmiK2vS2q9aIlLPCZsWlNNl
         qw/t+sdQet3tq0C2p18gILvjm9qpRu+EDftwUMgGmog19Uy+82ACD6mDJSGqT+KWapbO
         k8M4qaiRS7UQTmcBUj01JRX47aWM1KX7YfbIvriRnQ1iAY6a7OwyzTo2J3f0JAs+YbIU
         voJbb+lx/5wYSyiAhc2JYErYMYIrdzYycVumx9ku/K0Z3YrVI9sWRl0EFYXllIYS6DPG
         IHSg==
X-Received: by 10.204.229.139 with SMTP id ji11mr12737437bkb.4.1385543336042;
        Wed, 27 Nov 2013 01:08:56 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id z6sm54525899bkn.8.2013.11.27.01.08.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 27 Nov 2013 01:08:55 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <87fvqlfpmw.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238408>

Am 24.11.2013 22:36, schrieb Thomas Rast:
> Jeff King <peff@peff.net> writes:
[...]
> 
> I think I'll also lend you a hand writing Documentation/technical/api-khash.txt
> (expect it tomorrow) so that we also have documentation in the git
> style, where gitters can be expected to find it on their own.
> 

Khash is OK for sha1 keys, but I don't think it should be advertised as a second general purpose hash table implementation. Its far too easy to shoot yourself in the foot by using 'straightforward' hash- and comparison functions. Khash doesn't store the hash codes of the keys, so you have to take care of that yourself or live with the performance penalties (see [1]).

[1] http://article.gmane.org/gmane.comp.version-control.git/237876
