From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [RFC PATCH 4/4] Make git fetch verify signed tags
Date: Thu, 27 Nov 2008 19:19:01 -0500
Message-ID: <20081128001901.GC29662@euler>
References: <1227497000-8684-1-git-send-email-deskinm@umich.edu> <1227497000-8684-2-git-send-email-deskinm@umich.edu> <1227497000-8684-3-git-send-email-deskinm@umich.edu> <1227497000-8684-4-git-send-email-deskinm@umich.edu> <1227497000-8684-5-git-send-email-deskinm@umich.edu> <alpine.DEB.1.00.0811241143410.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 28 01:20:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5r5v-0002D5-7F
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 01:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbYK1ATK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 19:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752816AbYK1ATJ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 19:19:09 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:27343 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbYK1ATI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 19:19:08 -0500
Received: by yx-out-2324.google.com with SMTP id 8so507095yxm.1
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 16:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=Ge8XQi9nzyeoskK6IQZSxzsrsziG9wAHPOrRRaiq5r4=;
        b=kWk2McnnReiaqddvfWGGqoCnjLs54jiNWOkF87JjpiZyCWim9jqKceHFY0yDHtxJ8r
         k4MB1s7yA/EIpp9y1zaFdE9TQnGlpilDCsWM05+9/6NShjI8dZyj6OYs9zjgEc/THfA2
         XbPRTh/8JLjVuCJ4WRX5Wv44oY4qlFBI0rngY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=NufQVOxtEp7Y0j+b+HwyvekTcfqfUEqRllrNm7L+u1y3AYuAXWCZZFjV1i6UnkZRlo
         zBoJQuwCj8QE1VFMW5C6tjLZ4uWtBw26gpva4liwhrUJV+TeJdU3ee4x2RIvIUNMqoG+
         oH4iLC+HhsT4Qw0+4XDYdZm6gbVHVH1709SdM=
Received: by 10.65.215.14 with SMTP id s14mr8048648qbq.5.1227831546248;
        Thu, 27 Nov 2008 16:19:06 -0800 (PST)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id 28sm820501qbw.11.2008.11.27.16.19.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Nov 2008 16:19:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811241143410.30769@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101849>

On Mon, Nov 24, 2008 at 11:44:40AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 23 Nov 2008, Deskin Miller wrote:
> 
> > When git fetch downloads signed tag objects, make it verify them right 
> > then.  This extends the output summary of fetch to include "(good 
> > signature)" for valid tags and "(BAD SIGNATURE)" for invalid tags.  If 
> > the user does not have the correct key in the gpg keyring, gpg returns 
> > 2, verify_tag_sha1 returns -2 and nothing additional is output about the 
> > tag's validity.
> 
> This must be turned off by default, IMO.  You cannot expect each and every 
> developer to have gpg _and_ all those public keys installed.

Adding a configuration variable to control this makes sense, and is on
my TODO list for v2 (core.autoVerifyTags?).  However, I don't see a
compelling reason to make it off by default, as if gpg isn't found, or a
particular public key isn't in the keyring, the output is no different
from what fetch prints now.

Deskin Miller
