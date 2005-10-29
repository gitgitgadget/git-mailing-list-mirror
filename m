From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Use LDFLAGS instead of ALL_CFLAGS when linking.
Date: Sat, 29 Oct 2005 09:24:03 -0700
Message-ID: <4363A223.4040806@zytor.com>
References: <4363250C.8030200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 29 18:25:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVtVf-00036d-Lt
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 18:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVJ2QYO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 12:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVJ2QYO
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 12:24:14 -0400
Received: from terminus.zytor.com ([192.83.249.54]:64453 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751217AbVJ2QYO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 12:24:14 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9TGO4LB001363
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 29 Oct 2005 09:24:05 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4363250C.8030200@op5.se>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10798>

Andreas Ericsson wrote:
> The patch says it all really. It lets users specify their own linking 
> options and unclutters the build-output somewhat.
> 
> index 5b0306d..f547d45 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -360,7 +360,7 @@ git-cherry-pick: git-revert
>         $(CC) -o $*.o -c $(ALL_CFLAGS) $<
> 
>  git-%$X: %.o $(LIB_FILE)
> -       $(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
> +       $(CC) -o $@ $(filter %.o,$^) $(LIBS) $(LDFLAGS)
> 

Typically $(LDFLAGS) comes before $(LIBS).  This is not insignificant, 
since some people put library seach options into LDFLAGS.

	-hpa
