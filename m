From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 15/20] t/t5000-tar-tree.sh: avoid "test <cond> -a/-o
 <cond>"
Date: Tue, 10 Jun 2014 11:49:15 -0700
Message-ID: <20140610184913.GD72751@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
 <1402066563-28519-16-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jun 10 20:50:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuR7O-0006TF-53
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 20:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbaFJSty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 14:49:54 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:44434 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbaFJStx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 14:49:53 -0400
Received: by mail-pb0-f51.google.com with SMTP id rp16so1100152pbb.24
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6GxHgrTCSEpBFULdCvEU3SE22mWqrhStD6azyn0AbMQ=;
        b=sU+wmF5l3bEAzvQpH3qSLVIw/WfhHdIf+9caXU2/w+oU9hjbHic67KG7n23O7xFrqY
         DfBN89U1+vF+4e1LwG+pzDLCY2E5rvaDboOJKiowLkOKuzn2KxvAL0VsU0QunWaXSrjV
         pYT007A4yUTirNwTwdvuZS8r2TUvkavqNckGvgfeG/RiFo2RmaVLi6Bnl8T/HxQmpSjt
         OfdcMETwdjEomKW+c+0L/9ELy8fW0Zpxh7Zv8wWdW0iSrV7Uu1qWfzIBI+/sczDo12Ir
         dgPqhQ84KHBq4RBWGxO7/F3ChCLeB69I9VwVDy5dkh8qgmOrKUk7B/KTz/6j3v5+/AL2
         CDPQ==
X-Received: by 10.68.197.39 with SMTP id ir7mr13855070pbc.78.1402426193560;
        Tue, 10 Jun 2014 11:49:53 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id ys1sm16879698pab.7.2014.06.10.11.49.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 11:49:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1402066563-28519-16-git-send-email-gitter.spiros@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251213>

On Fri, Jun 06, 2014 at 07:55:58AM -0700, Elia Pinto wrote:
> The construct is error-prone; "test" being built-in in most modern
> shells, the reason to avoid "test <cond> && test <cond>" spawning
> one extra process by using a single "test <cond> -a <cond>" no
> longer exists.
>=20
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  t/t5000-tar-tree.sh |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 74fc5a8..ad6fa0d 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -72,7 +72,7 @@ check_tar() {
>  			for header in *.paxheader
>  			do
>  				data=3D${header%.paxheader}.data &&
> -				if test -h $data -o -e $data
> +				if test -h $data || test -e $data
>  				then

This looks okay, but it raises a question for the original author
(Ren=C3=A9, I think that's you so I've added you to the To: line).

Should that be "test -f" instead of "test -e"?

This is a very minor note and should not block this patch.
--=20
David
