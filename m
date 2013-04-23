From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t4202 (log): add test for --follow over a merge
Date: Mon, 22 Apr 2013 23:28:21 -0700
Message-ID: <20130423062821.GA32683@elie.Belkin>
References: <1366643912-3942-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 08:28:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUWiT-0007jW-Of
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 08:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755603Ab3DWG2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 02:28:30 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36593 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755374Ab3DWG23 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 02:28:29 -0400
Received: by mail-pd0-f174.google.com with SMTP id y14so219782pdi.33
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 23:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=iphZ5QTISCBnEE+h5E03WUNupvNO75r07Kn1MjodMIs=;
        b=nMM9TNWp7xT7Rc8zRcD/XlcJV0ZbRGTcG5xAeLIsD7HzwMtBlzfmIjHA+TaBClaCGs
         WCQ2Y0FSMr7QgYdFZkG59MVsVz5giD6xcrQHei9C+RwdxqAW1jxH0aXMQfscyob5W1ze
         zASdgnBchI21yFRlk1VJVWyGnAexNYkuBmT2j5ViuVTExf1Ux93pCOC1WSZ70TaPSQSF
         6UvHeIKC044EfuPzPY2b2Jetly835wHMV3pAinSfYtTybt+fU8bzy0Az5u7xKbY+XU2f
         yK1WhXVdeXf9VnEPnWKySp0PX4TofXIL2Cdqkdxb0NeCr49VcALJs6CzBFfSdxqkrMfQ
         fpYg==
X-Received: by 10.68.184.100 with SMTP id et4mr31641359pbc.48.1366698508787;
        Mon, 22 Apr 2013 23:28:28 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id to7sm30473052pab.0.2013.04.22.23.28.26
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 23:28:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1366643912-3942-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222134>

Hi,

Ramkumar Ramachandra wrote:

> The --follow feature can be used to follow the history of a file over
> a merge commit, and is useful even when the file hasn't been
> copied/renamed.  Add a test to show off this feature.

I can't claim to have followed the discussion, but I don't understand
the above.  If the file's name hasn't changed, the most one can hope
for is that --follow doesn't hurt, no?

[...]
> +	cat >expect <<-\EOF &&
> +	df26551 add a line to the beginning of ichi
> +	882d8d9 add a line to the end of ichi
> +	2fbe8c0 third
> +	f7dab8e second
> +	3a2fdcb initial
> +	EOF
> +	test_cmp expect actual

t/README explains:

| As with any programming projects, existing programs are the best
| source of the information.  However, do _not_ emulate
| t0000-basic.sh when writing your tests.  The test is special in
| that it tries to validate the very core of GIT.
[...]
|          other tests that simply rely on basic parts of the core
| GIT working properly should not have that level of intimate
| knowledge of the core GIT internals.  If all the test scripts
| hardcoded the object IDs like t0000-basic.sh does, that defeats
| the purpose of t0000-basic.sh, which is to isolate that level of
| validation in one place.

Hard-coding object names makes it painful to tweak a given test and
tests that come before it, lest a timestamp or the phase of moon
change and cause the object names to drift.   Don't do it, except
in t0000.

Hope that helps,
Jonathan
