From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCHv2] gitk: Replace "next" and "prev" buttons with down and
 up arrows.
Date: Tue, 21 Jan 2014 10:33:02 -0500
Message-ID: <52DE932E.7090008@xiplink.com>
References: <20131008193618.GE9464@google.com> <1387382653-8385-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Lucas Sandery [three am design]" <lucas@threeamdesign.com.au>,
	Paul Mackerras <paulus@samba.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 16:41:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5dSP-0000rQ-3P
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 16:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbaAUPlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 10:41:37 -0500
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:53254 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbaAUPlg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 10:41:36 -0500
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jan 2014 10:41:35 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp31.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 0D9DE3A82B3;
	Tue, 21 Jan 2014 10:32:40 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp31.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 693D03A8551;
	Tue, 21 Jan 2014 10:32:39 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1387382653-8385-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240752>

On 13-12-18 11:04 AM, Marc Branchaud wrote:
> Users often find that "next" and "prev" do the opposite of what they
> expect.  For example, "next" moves to the next match down the list, but
> that is almost always backwards in time.  Replacing the text with arrows
> makes it clear where the buttons will take the user.

Any opinions on this, either way?

I've grown fond of the down/up arrows.  I find them much clearer than the
current next/prev buttons.

My only niggle about this patch is that the buttons are much smaller,
requiring a bit more precision clicking.  But the smaller buttons allow more
room for other widgets.

		M.


> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
> 
> Finally got around to drawing some up and down arrows.
> 
> 		M.
> 
>  gitk | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/gitk b/gitk
> index 33c3a6c..abd2ef3 100755
> --- a/gitk
> +++ b/gitk
> @@ -2263,9 +2263,35 @@ proc makewindow {} {
>  
>      # build up the bottom bar of upper window
>      ${NS}::label .tf.lbar.flabel -text "[mc "Find"] "
> -    ${NS}::button .tf.lbar.fnext -text [mc "next"] -command {dofind 1 1}
> -    ${NS}::button .tf.lbar.fprev -text [mc "prev"] -command {dofind -1 1}
> +
> +    set bm_down_data {
> +	#define down_width 16
> +	#define down_height 16
> +	static unsigned char down_bits[] = {
> +	0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01,
> +	0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01,
> +	0x87, 0xe1, 0x8e, 0x71, 0x9c, 0x39, 0xb8, 0x1d,
> +	0xf0, 0x0f, 0xe0, 0x07, 0xc0, 0x03, 0x80, 0x01};
> +    }
> +    image create bitmap bm-down -data $bm_down_data -foreground $uifgcolor
> +    ${NS}::button .tf.lbar.fnext -width 26 -command {dofind 1 1}
> +    .tf.lbar.fnext configure -image bm-down
> +
> +    set bm_up_data {
> +	#define up_width 16
> +	#define up_height 16
> +	static unsigned char up_bits[] = {
> +	0x80, 0x01, 0xc0, 0x03, 0xe0, 0x07, 0xf0, 0x0f,
> +	0xb8, 0x1d, 0x9c, 0x39, 0x8e, 0x71, 0x87, 0xe1,
> +	0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01,
> +	0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01};
> +    }
> +    image create bitmap bm-up -data $bm_up_data -foreground $uifgcolor
> +    ${NS}::button .tf.lbar.fprev -width 26 -command {dofind -1 1}
> +    .tf.lbar.fprev configure -image bm-up
> +
>      ${NS}::label .tf.lbar.flab2 -text " [mc "commit"] "
> +
>      pack .tf.lbar.flabel .tf.lbar.fnext .tf.lbar.fprev .tf.lbar.flab2 \
>  	-side left -fill y
>      set gdttype [mc "containing:"]
> 
