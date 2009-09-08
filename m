From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Improving merge failure message
Date: Tue, 8 Sep 2009 11:11:24 +0200
Message-ID: <81b0412b0909080211k19470327x97b19eb0bd6ab700@mail.gmail.com>
References: <20090908153101.6117@nanako3.lavabit.com>
	 <7vbplmhr0i.fsf@alter.siamese.dyndns.org>
	 <7veiqhgb4y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 11:13:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkwlP-000133-Jr
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 11:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbZIHJLX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2009 05:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbZIHJLX
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 05:11:23 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:41878 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbZIHJLX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2009 05:11:23 -0400
Received: by fxm17 with SMTP id 17so2458679fxm.37
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=btsYL5fYFGiotDOhKWL5yDd68DjA3BKHVRlR2I2o8fI=;
        b=p3dfsRx0kW9zmQYPRl8n9FxJzIW2zA2XIZ2raLqnyIDqE0BqreormeeLb+34D1wLx4
         UV5WQ0bYVovrvMHbPw7/TXEFhjkAj1lR5U4udXiyaxrPbi2F7Y5cYVKUn75fGp2LYYXf
         6tfeZOKCR981HZ0WR646ZhOcD9xApFq7vRmDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J2wY7DXjYFp2lM6rfISIOk/wrFQ5O8vf4RwfHkWDmSWkf+5vkI36rwDW2JcQPnutmd
         rVpULT8ua6gkVBff63BqYmDUl2HEL85b+jM1okwfch27tGsmXvk3Lau1mR0LSI6VNwQO
         GAVnk+6MkWQsKqU3IPt+2dAlB9Qfag2r130Ps=
Received: by 10.204.34.208 with SMTP id m16mr13024049bkd.47.1252401084699; 
	Tue, 08 Sep 2009 02:11:24 -0700 (PDT)
In-Reply-To: <7veiqhgb4y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127994>

On Tue, Sep 8, 2009 at 09:15, Junio C Hamano<gitster@pobox.com> wrote:
> @@ -170,6 +170,18 @@ static int git_merge_trees(int index_only,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tree_desc t[3];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct unpack_trees_options opts;
> + =C2=A0 =C2=A0 =C2=A0 static struct unpack_trees_error_msgs msgs =3D=
 {

You can make these const, the struct is copied anyway:

> + =C2=A0 =C2=A0 =C2=A0 opts.msgs =3D msgs;

Here --^
