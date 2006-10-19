From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH] reduce delta head inflated size
Date: Thu, 19 Oct 2006 09:49:01 -0400
Message-ID: <118833cc0610190649o484afdc8lb871d4b3c5361166@mail.gmail.com>
References: <Pine.LNX.4.64.0610181541280.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 15:49:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaYH2-0003GM-7j
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 15:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161420AbWJSNtH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 09:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161424AbWJSNtH
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 09:49:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:36881 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161417AbWJSNtC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 09:49:02 -0400
Received: by wx-out-0506.google.com with SMTP id h28so622872wxd
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 06:49:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DMv385YmE03A2ygiK4Vn0LKdxYKVsjApksHDx2PMuZXzfL4xnzGEhiS9RjdV9EkyBOJkbL8ULb96QSo+0aRWECeJHcQ5Z07OKy7vnxt59xbA0POtvQdRduJeGbwB1FmPW+JlB466aLTdyNOAg01N7sfnY4QsYeHcTR0qUO+E60I=
Received: by 10.70.108.18 with SMTP id g18mr18439407wxc;
        Thu, 19 Oct 2006 06:49:01 -0700 (PDT)
Received: by 10.70.97.15 with HTTP; Thu, 19 Oct 2006 06:49:01 -0700 (PDT)
To: "Nicolas Pitre" <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610181541280.1971@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29348>

On 10/18/06, Nicolas Pitre <nico@cam.org> wrote:
> Supposing that both the base and result sizes were both full size 64-bit
> values, their encoding would occupy only 9.2 bytes each.  Therefore
> inflating 64 bytes is way overkill.  Limit it to 20 bytes instead which
> should be plenty enough for a couple years to come.

2^63 ~ 9.2e18

Thus one signed 64-bit number can take up 1 sign + 19 digits + 1 nul.
That's 21 bytes.

If you don't like the constant, 4*sizeof(integer type) should work.
(Assuming sizeof measures in bytes.)

M.
