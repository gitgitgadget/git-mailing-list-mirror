From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] Skip unwritable tests for root
Date: Mon, 07 Jul 2008 21:14:06 +0200
Message-ID: <48726AFE.3070400@gmail.com>
References: <1214809551-14603-1-git-send-email-ferdy@ferdyx.org> <7vabh31e9p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Fernando J. Pereda" <ferdy@ferdyx.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 00:39:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFzMu-0001jf-8Q
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 00:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbYGGWih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 18:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754044AbYGGWih
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 18:38:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:26515 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085AbYGGWig (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 18:38:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so902859fgg.17
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 15:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=KRfwUlz3u1sA6y0I0vFP4vvFfCZQYJsSIsDnHyobLsA=;
        b=KYdjoEBYLtbyzLDeaNqkZ6wbOs6H70pujDbbuIW1nKOBx0WzEItXbrCQHMPeIdkSaM
         JxZ72EvlUKPlzBYlhW4h+3wEj5JjNawXoEP04O6Uhmts1qijVA4VYsyWEtTHRlgDQD6Q
         GJKIcHxQGPppaDjw4pOedAmSvBRdSpa16PSok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=n143l6TMS6UoBN7I5CncGoYmjsHIEX+GGbKnNx8qpIbcckvp+wYcyaYcueHXXC8lS5
         TT+jjaDj40yg8buXO8Hdk4XZ+PTfbaN5y94b1ITmyHID7ellk2ZTmCfKYAq/OL3ABfJN
         CaDZOny0if9W8JFmmi/O+qDw1X7YD8TDV2rq8=
Received: by 10.86.96.18 with SMTP id t18mr4765500fgb.17.1215470313997;
        Mon, 07 Jul 2008 15:38:33 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.220.244])
        by mx.google.com with ESMTPS id e11sm5557326fga.4.2008.07.07.15.38.31
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Jul 2008 15:38:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vabh31e9p.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87664>

Junio C Hamano wrote:
> If we were to do anything, don't we rather want to fail everything upfront
> when the tests are run by root [because it's crazy]?

I think that unless/until someone wants to submit a patch that makes the
tests fail upfront, we should use Fernando's patch; it's an improvement
over the current situation.

I'm actually not entirely sure if skipping or failing everything if the
tests are run as root is a good idea -- for instance, neither skipping
nor failing seems appropriate for Gentoo's root-in-a-sandbox situation.

Jakub Narebski wrote:
> "Fernando J. Pereda" <ferdy@ferdyx.org> writes:
>> +	test_expect_success '[...], skipping test' :
>> +	test_done
>> +	exit
>
> Yet another place that would profit from test_skip in test-lib.sh...

*nods*  I'd rather name it 'test_skip_all' for clarity though, at least
if it contains "test_done; exit".  (I'm not volunteering to send a
patch, FTR...)
