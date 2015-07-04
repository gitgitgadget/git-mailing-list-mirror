From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git name-rev not accepting abbreviated SHA with --stdin
Date: Fri, 3 Jul 2015 19:03:21 -0700
Message-ID: <CAPc5daVFRuBsZEZO=y5hY=ErQf7uy36Ejw2CLb3s8N5y6+T_ww@mail.gmail.com>
References: <558A2405.2090709@gmail.com> <xmqqsi9g8x51.fsf@gitster.dls.corp.google.com>
 <558B60E4.9020604@gmail.com> <xmqqbnft5eja.fsf@gitster.dls.corp.google.com> <5597365E.7070508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 04:18:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBD2S-0004by-Jt
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 04:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbbGDCDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 22:03:43 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:32914 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755195AbbGDCDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 22:03:41 -0400
Received: by oiyy130 with SMTP id y130so87407740oiy.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 19:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=y+xHBfI5GTjUJ9vziP610qrx21rxt3IqqjhOEnc/cBY=;
        b=XsR2mHx3ZT3BDBK3RjGmtOKNT9ZxB/ZUqnNfSRW6xQ8y7xdB7yILCQaMBT2sRYVKib
         J3qMyN2UdbrmG53uH6qsgakxrm8aqvM3W5jtHoUl+2kK/ZWYm62lAMAx166z24Z3JsgM
         mjdWuPgwT5NiJnB7uDLARxmnGYf5dJCG0qp/Xbgp1w+qnkUP44IPIKwL8wYuD0UFKee7
         2e4bRRMc6ksc5I90K0DJJDBaCoje4ZDzRlqZBRJgJq6yNA0kpdG1PqyOygHWhSvTRrU6
         9r2o8x7OtufUYSnxGU1ucZQmfTUsF9vbvfmwIopKllth2YbDKqMdBYvMuUDFKOxF3FEz
         pH6A==
X-Received: by 10.182.213.99 with SMTP id nr3mr34036301obc.5.1435975420559;
 Fri, 03 Jul 2015 19:03:40 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Fri, 3 Jul 2015 19:03:21 -0700 (PDT)
In-Reply-To: <5597365E.7070508@gmail.com>
X-Google-Sender-Auth: jzMuFlGQnVYqVTxpli0TYfO6TAM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273342>

On Fri, Jul 3, 2015 at 6:26 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> Jokes apart, I'm not sure the chances of *both* those things happening
> -- an accidental hash-like string in the text *and* it matching an
> existing hash -- are high enough to bother.  If it can be done without
> too much code, it probably should.

To be fair to the original implementor, I think we didn't have an API to ask
"do we have a committish object with this name?" with an abbreviated SHA-1.
All we had was "do we have an object with this name?".

As the only answer the command can give is an exteneded SHA-1 for
committish, it is understandable that hitting blobs and trees (which typically
are much more numerous than committishes) with false positives would have
been a real risk the implementation wanted to avoid.
