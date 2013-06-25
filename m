From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: git diff returns fatal error with core.safecrlf is set to true.
Date: Tue, 25 Jun 2013 22:29:52 +0200
Message-ID: <51C9FDC0.5020709@web.de>
References: <6a3d8a2b19a859d8c969ee434e1d6a89@meuh.org> <7vobazo4ds.fsf@alter.siamese.dyndns.org> <7vip17ktyz.fsf@alter.siamese.dyndns.org> <b8e932cba326588db09ebd0986913ac2@meuh.org> <7vbo6v9xrr.fsf@alter.siamese.dyndns.org> <7vli5z6uyq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Yann Droneaud <ydroneaud@opteya.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 22:46:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ura8P-00034P-MV
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 22:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab3FYUqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 16:46:37 -0400
Received: from mout.web.de ([212.227.15.4]:55970 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006Ab3FYU35 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 16:29:57 -0400
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0Lpeys-1UOGwA1UoA-00fQlz; Tue, 25 Jun 2013 22:29:52 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vli5z6uyq.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V03:K0:Ro9MBI/n/yj30UXuQ4GS05Ymzvgqct2sbpVFodRteFs0rRxHSJu
 ofvkXuvOj0kwGiWm7BIHqnAhUZBXIccHrIy0IRoOlJ359pCZpHD673kFxyc4WUW1ed6aRNY
 ZvKYWbsK6e9LtMadu87Zp37dVdOH48XJ6Ic91pu+bhoM1JoEdCxgy3Civ4FLFPuC8GBxXZu
 LsnKq794xGNz+QwpolLVw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228990>

> +++ b/diff.c
> @@ -2647,6 +2647,10 @@ static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
>  int diff_populate_filespec(struct diff_filespec *s, int size_only)
>  {
>  	int err = 0;
> +	enum safe_crlf crlf_warn = (safe_crlf != SAFE_CRLF_FAIL
> +				    ? safe_crlf
> +				    : SAFE_CRLF_WARN);

Thanks, 
Does it makes sense to write it the other way around?

enum safe_crlf crlf_warn = (safe_crlf == SAFE_CRLF_FAIL 
                           ? SAFE_CRLF_WARN 
                           : safe_crlf);
