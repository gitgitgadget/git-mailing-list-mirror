From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH] strtoul_ui: actually report error in case of negative
 input
Date: Mon, 14 Sep 2015 23:26:47 +0300
Message-ID: <20150914202647.GA7806@wheezy.local>
References: <1442181636-27821-1-git-send-email-max@max630.net>
 <vpqr3m1seap.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 14 22:27:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbaLE-0002O3-4g
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 22:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbbINU1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 16:27:03 -0400
Received: from p3plsmtpa08-08.prod.phx3.secureserver.net ([173.201.193.109]:49292
	"EHLO p3plsmtpa08-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751448AbbINU1B (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2015 16:27:01 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa08-08.prod.phx3.secureserver.net with 
	id H8Sn1r0065B68XE018SuQQ; Mon, 14 Sep 2015 13:26:58 -0700
Content-Disposition: inline
In-Reply-To: <vpqr3m1seap.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277863>

On Mon, Sep 14, 2015 at 08:30:54AM +0200, Matthieu Moy wrote:
>> Fix it by changing the last check to trigger earlier, as soon as it
>> becomes bigger than INT_MAX.
> 
> What if the value is actually greater than INT_MAX? The function is
> returning an unsigned long (64 bits on 64bits architectures), and your
> version is restricting it to integers smaller than 2^31, right?

the return type of the function is "int", so this is not
going to work anyway.

As I mentioned, some negative values are still accepted
as coresponding mod 2**32 positive numbers (-3221225472 as
1073741824), so there really is room for improvement, but it
cannot be accomplished just by examining strtoul output.

I saw in the list archives an attempt to abandon the
function in favor of more accurate parser [1], but seems
like it did not make it into the project.

[1] http://thread.gmane.org/gmane.comp.version-control.git/265635

-- 
Max
