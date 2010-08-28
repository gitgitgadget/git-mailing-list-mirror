From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] t6200-fmt-merge-msg: Exercise 'merge.log' to
 configure shortlog length
Date: Fri, 27 Aug 2010 21:05:12 -0500
Message-ID: <20100828020512.GE2004@burratino>
References: <1282918490-5190-1-git-send-email-artagnon@gmail.com>
 <1282918490-5190-2-git-send-email-artagnon@gmail.com>
 <20100828020018.GD2004@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 04:07:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpApB-0007yd-KD
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 04:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917Ab0H1CHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 22:07:09 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41668 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab0H1CHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 22:07:08 -0400
Received: by gyd8 with SMTP id 8so1355903gyd.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 19:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3VgyvL8zEC5WdenlGPRCjzDnHa3GkhuqyMZyRdlPT88=;
        b=ilsM1HTuwOWstH58D0VG5g4VFNWy1kyjKOQSMBBUwro8dQLwjMJ+Rjr6K2LICBovCr
         UXwRnkxwnZptS6+8+tNnDUJGlBV5fwJ3LxLnBExYRvokFYJIKHFEkFVqv+5ZjywSlXUG
         DLltjs32ltiQF2kOl302igN65R857CTDtPCOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CmE0E/pTu+g3W0MBHVi/qNNsrjoKy4zZm3Ktfi/5gKYNkJZyFs562f976AC0hzrtdA
         ZvMisDWTKiOX/8ojnA7NQPcF1wl6B3XOYv/1MVirI3wvM6rp5mhV4Ot32Kr6dgN0MK2G
         +NI2ofLXrYjmP3iifIsrmiUTfJh00AcqaLOv8=
Received: by 10.100.167.2 with SMTP id p2mr1755284ane.148.1282961222397;
        Fri, 27 Aug 2010 19:07:02 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t30sm7318402ann.7.2010.08.27.19.07.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Aug 2010 19:07:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100828020018.GD2004@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154629>

Jonathan Nieder wrote:

> Maybe something like this?
> 
> 	test_expect_success 'setup: clear [merge] configuration' '
> 		test_might_fail git config --unset-all merge.log &&
> 		test_might_fail git config --unset-all merge.summary
> 	'
> 
> 	test_expect_success 'set up FETCH_HEAD' '
> 		git checkout master &&
> 		git fetch . left
> 	'
> 
> 	test_expect_success 'merge.log=3 limits shortlog length' '
> 		test_might_fail git config --unset merge.log &&
> 		test_might_fail git config --unset merge.summary &&

Erm, these two lines wouldn't be necessary given the earlier setup,
of course.
> 
> 		cat >expected <<-\EOF &&
> 		  Left #3
> 		  ...
> 		EOF
> 		git -c merge.log=3 fmt-merge-msg <.git/FETCH_HEAD >msg &&
> 
> 		tail -n 2 msg >actual &&
> 		test_cmp expected actual
> 	'

Sorry for the noise.

*goes off to sleep*
