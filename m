From: Thiago Farina <tfransosi@gmail.com>
Subject: socket_perror() "bug"?
Date: Sun, 30 Mar 2014 16:32:54 -0300
Message-ID: <CACnwZYc2py4dxehg2=gnnPLxwJaRqXYTLQvC1O7YuoqAWsZ0Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 30 21:33:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WULTY-0002O7-Nq
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 21:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbaC3Tc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2014 15:32:56 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:63364 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbaC3Tcz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 15:32:55 -0400
Received: by mail-qc0-f180.google.com with SMTP id w7so8215592qcr.11
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=KWUjHGZC0fvDSsCeSGOUG6avJvWs5lSkPAs3bni1Zmg=;
        b=gMVFWREj7GyuVf+6py+pq0B5v4Ja3oGzlH356jEZQN/sjDglDUIyQFdpTN4bAq2GtL
         GAGlypCZ9y/v+KHGG56WqtBQ78cImoBKZ6GnYlF+VJ9rlVd7fsqalrAmgydzKUulCT3N
         Nyj+sdZEd5DOb2LrbRtQKVReQjYKXOjL1wEzBWyihb8/6clG8QSpTAn6DRvA1ohD5rnm
         sD41uzUwq9nr3ixljt2aMKQu4C/UWDVb1VlemxkKnhYdlO+o5GEsqPpH38jIYxyFSsuH
         lyah+lF/tsfZsAD/aRyqPQJHsaaYc4h/Rd6uciH65byVowJjyqltIiagxhV4FlpWxNoX
         VVCQ==
X-Received: by 10.224.98.139 with SMTP id q11mr23285871qan.44.1396207974834;
 Sun, 30 Mar 2014 12:32:54 -0700 (PDT)
Received: by 10.224.195.138 with HTTP; Sun, 30 Mar 2014 12:32:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245486>

Hi,

In imap-send.c:socket_perror() we pass |func| as a parameter, which I
think it is the name of the function that "called" socket_perror, or
the name of the function which generated an error.

But at line 184 and 187 it always assume it was SSL_connect.

Should we instead call perror() and ssl_socket_error() with func?

--
Thiago Farina
