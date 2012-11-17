From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/7] completion: add tests for invalid variable name
 among completion words
Date: Sat, 17 Nov 2012 15:40:59 -0800
Message-ID: <20121117234059.GD3815@elie.Belkin>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
 <1353150353-29874-5-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Nov 18 00:41:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZs0m-0006RH-8h
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 00:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab2KQXlF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 18:41:05 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:54456 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab2KQXlD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 18:41:03 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so206815dak.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 15:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ivyPdTXZa83zyUvt4jMqOJttcK5wCh2eJIFX8dJyLiw=;
        b=L2e3q9T8rIE3QBW7qAsyfIMBjaI2kAnuhmW3iFpE9YjBnu5IYlyM4r1dQ2FLu9agFC
         r4PRjIt+xPJOVJDk16ws+yvEv0raOB6zkHAt5zWI5dRobV86jlIhUklFFIZT0pZWqJhU
         BXV9K37R/s7GqhvCmBaG1AZ+vyT2KGFMEsnj6ROiPcmLDS78mmL0wYaUqxtsCnhAARUo
         qg+IGmUdKRmBYY+2aljTC4OJyhZnrx1/F3dcoqe5XmExC5Kj85tku7EppcQZrpKdPxeh
         UJITuIooxV+ckSmUba2ZNvn7s3jx8fszsLAGz9nbT/gwGiXEsC0H2HiZnI/6nTcxOeYm
         QM/A==
Received: by 10.66.76.162 with SMTP id l2mr24906901paw.13.1353195663652;
        Sat, 17 Nov 2012 15:41:03 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id na4sm3568391pbc.18.2012.11.17.15.41.01
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Nov 2012 15:41:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353150353-29874-5-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209986>

SZEDER G=C3=A1bor wrote:

>                                                      The breakage can
> be simply bogus possible completion words, but it can also be a
> failure:
>
>   $ git branch '${foo.bar}'
>   $ git checkout <TAB>
>   bash: ${foo.bar}: bad substitution

Or arbitrary code execution:

	$ git branch '$(>kilroy-was-here)'
	$ git checkout <TAB>
	$ ls -l kilroy-was-here
	-rw-rw-r-- 1 jrn jrn 0 nov 17 15:40 kilroy-was-here

The final version of this patch should go to maint.  Thanks for
catching it.
