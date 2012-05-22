From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 19:18:00 +0700
Message-ID: <CACsJy8Dw+mbP+ttTP6gAfX9o4q4NyZgPYpbhS=tket=5fvBXwg@mail.gmail.com>
References: <4FB9F92D.8000305@alum.mit.edu> <20120521174525.GA22643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 14:18:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWo2w-0006xn-6D
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 14:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298Ab2EVMSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 08:18:33 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:43670 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab2EVMSd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 08:18:33 -0400
Received: by wibhn6 with SMTP id hn6so3465047wib.1
        for <git@vger.kernel.org>; Tue, 22 May 2012 05:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kJpGPVBk2AZ0DJO73A8dwuVNb5qrHTb4LF1fBXja6LE=;
        b=BJMUH9HM5BNr+fuB+aGbEg1bvrPMusLDy4nRuFxPyQkfC0Cg1sPwvxdXpdaUs9aXqn
         nKQdoe/7g30H29iKDO2cbHJWxmkW20sQSmwc4yxSuBG5m4h0hgD52EZzruMzVUd6O7RP
         zgzNraRla3gdvgFGJcA1RoDZKr+GqF34vI++qqVMRDOqF5Jw1qYQUutAcCjhXxX5gORu
         ijlta1Zq4UCfQpl/nngu3MwZfUKYxaUj7/7gc3QrMyU565OMO8vU9ctZN80NYiX5xxHa
         I8vouH6QHvaiqCDtinAmE3AT7p/blgPaudIZuMq6l02DTncjyDhRV+FQUt1eqICZLWXF
         aHpQ==
Received: by 10.180.8.69 with SMTP id p5mr34489636wia.17.1337689111986; Tue,
 22 May 2012 05:18:31 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Tue, 22 May 2012 05:18:00 -0700 (PDT)
In-Reply-To: <20120521174525.GA22643@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198194>

On Tue, May 22, 2012 at 12:45 AM, Jeff King <peff@peff.net> wrote:
> The rails/rails network repository at GitHub (i.e., a master repo with
> all of the objects and refs for all of the forks) has about 400K refs,
> and has been the usual impetus for me finding and fixing these sorts of
> quadratic problems.

Off topic and pure speculation. With 400k refs, each one 20 byte in
length, the pathname part only can take 7MB. Perhaps packed-refs
should learn prefix compressing too, like index v4, to reduce size
(and hopefully improve startup speed). Compressing refs/heads/ and
refs/tags/ only could gain quite a bit already.
-- 
Duy
