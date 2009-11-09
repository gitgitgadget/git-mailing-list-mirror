From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [RFC PATCH 3/3] t5551-http-fetch: Work around broken Accept 
	header in libcurl
Date: Mon, 9 Nov 2009 10:37:52 -0800
Message-ID: <905315640911091037i5e99c719rf754db7c95f0b069@mail.gmail.com>
References: <1257790237-30850-1-git-send-email-spearce@spearce.org> 
	<1257790237-30850-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 09 19:38:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Z87-00042l-30
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 19:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbZKISiI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 13:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbZKISiH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 13:38:07 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:39796 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbZKISiG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 13:38:06 -0500
Received: by pzk26 with SMTP id 26so2276324pzk.4
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 10:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=tWifyZvzwzCkD+WtAL95KUkRZbwAP0OQthLzOFypdE4=;
        b=Ughdgtw9RjYiNAE5qSC+hdUnCD1lFQX5TT9b0aQ7E+ROqRQ8clr51LRDq4v3kb9IUt
         k9jHNcrmKorLZ2CYUEBe98lzMZXWRH2weIbQybySKqlFO8jZU7Pw5v3QOBQTFvTx4y8x
         4KbcPgW9/pOiP1m4blWpPw0HHFJHnL+0YLugU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=QzN0sm36tnWGGjksxRVJlfmwU6C4GxAnYzNYatkztoq6Zr8xElab26m6vSM3bMbcZt
         t6hUjXd8T1R+6Wxda28r+JLPsZ6tg1uUjQOKHaNhKPc3Lob52hpRljUhigXencbVH65y
         IV2X0MzCW29v60S6hiMsAtVEHsnz9H/ZxB1x4=
Received: by 10.142.247.5 with SMTP id u5mr892034wfh.44.1257791892064; Mon, 09 
	Nov 2009 10:38:12 -0800 (PST)
In-Reply-To: <1257790237-30850-3-git-send-email-spearce@spearce.org>
X-Google-Sender-Auth: 2613fc5998f08f69
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132505>

On Mon, Nov 9, 2009 at 10:10 AM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Unfortunately at least one version of libcurl has a bug causing
> it to include "Accept: */*" in the same POST request where we have
> already asked for "Accept: application/x-git-upload-pack-response".
>
> This is a bug in libcurl, not Git, or our test vector. =A0The
> application has explicitly asked the server for a single content
> type, but libcurl has mistakenly also told the server the client
> application will accept */*, which is any content type.
>
> Based on the libcurl change log, this "Accept: */*" header bug
> may have been fixed in version 7.18.1 released March 30, 2008:
>
> =A0http://curl.haxx.se/changes.html#7_18_1
>
> Rather than require users to upgrade libcurl we change the test
> vector to trim this line out of the 2nd request.
>
> Reported-by: Tarmigan <tarmigan+git@gmail.com>

Tested-by: Tarmigan <tarmigan+git@gmail.com>

> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
