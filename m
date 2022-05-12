Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE651C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 15:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347807AbiELPFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 11:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355038AbiELPFe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 11:05:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3B825509F
        for <git@vger.kernel.org>; Thu, 12 May 2022 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652367915;
        bh=XOxTjDAgRoaliUW+T5OKYgTLj3r0b03MFikwb5Wsv1s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TZd6iGZ/D/GHd/l9nZea4+LmLgkGcWVfJQNEQc81j5w6YnDeZMFYziMOJ/S7vyBgk
         TZBpnHOwMIO/k+SdFeelyzzpPA1w9ZmVPJgC0O6Q7DPDPbM5Fr16uDyMvbitpHI5rf
         GIE6UHwoSZSznEWyqodCrJdPeklH/BQUcEdN+Ogo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([213.196.213.50]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Nv-1oJqUy2VPN-00e5Gy; Thu, 12
 May 2022 17:05:13 +0200
Date:   Thu, 12 May 2022 17:05:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Torsten B??gershausen <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 16/28] fsmonitor--daemon: stub in health thread
In-Reply-To: <32fc6ba74378cda7a5060d63066d16333765973a.1650662994.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205121622030.352@tvgsbejvaqbjf.bet>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com> <32fc6ba74378cda7a5060d63066d16333765973a.1650662994.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zrlLkQf/ezrL4C/5MWOzzfPAy5lLIOYeZcVu0XIyrSc/gzqRK1A
 9nwvrqbsM8fmLbCHVlQW6i0X5jGrSScjLSaedEvBndwNG94arCcRqsQtpX6rX4CJt8ZrWox
 uPa750qaN8VW5XjnYTWutFsoqe+fILjLyjCbjctQcROiZDQLlMrNPbtb8rP3hWSFu1I6WBp
 5ogb560JddU/OaAHSAz5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZYkkJccBQSw=:gNldAWTOK05STOZ8bQ6sET
 uzDHAJjD9ZU1JbI1NSMMkDauMk+WIG+9t+YZv4EguPVAYgR6fHdankcvTxWAeVQkyjU0FmRsV
 REMppfbDtJRDbLZkgYSjFNmEFy4U86epgSjghoTwnbZGjjP87ZMkUuLqABOGUrEMrr4UuA98u
 Y+YK3MDgMBkKIUtcjlTiHJIvIN/3lfZMYbtA/deNaboq5jrHYlyxmK5E1Vh9VS/FteVLNC4+J
 +2J6kTLGqlJp2kWlZa2hqJ8HE8/YrF6cMceOu9pzsepHrl7BI4oZOHHeX3Qlj5K+lpVoF0ODL
 fnbqLzJEVdupPLPvz7LVLd3JNUE/mrWRY0iZ6+rf1RpoTWONqVxADB1QiUAtF+I6dK4FQmDm1
 BaFY9Lnup87Z3ROq6l3a5/TMWdQoHnS7KdO5Y5GEhS/rdNOCXU3dj3JKCdiXQrrkkX7NXA+R4
 RGZ7amLtU3D6PIxKmJag6cB6ICvqUWn2iKnZqbhlBKgw2MydrE9QFMVSGj4qDrEonoap2slR9
 ur2TqNcykkx0pu8dd1TuFG5uE/6nZ/3OKJPWEMa81kc1HQOkYx4vM5gWv9rlzN9v6cudZoxfw
 /iwIW20mXR70G4BMogxX4d7lHiTJ5lJUSXPVqfdmw5zaXr0ySH5GroiBpB2qLzJygTG5kn6fJ
 N2S6BpF6x8TS1lL2jKMeHwvrUdS8g3qyTEygPLOYxUD2i+I2al4HJ/FDnTf8Yf/8peMl/eiFj
 eWEPyzDR/ysrHSF2bzI8gn/lSutVyVgLYkR82OAv/XhGCB4ex/g1Lxds0GcHiFQl0wYX22Flw
 gqD7a4SjdgEs0syMX+QgO5wBdFv8m8yOIcr0MA+PGTz7w3U2AR8uamqXOlFhYL2BhWgK8PefH
 qEj+7TVgKVmxWvdfncwcc+0t5punjWQUa48nmQZj535Ezu9YsT+yHuJW0737FIRpKCnTLInKG
 elXbP8FYHIijkB4WCnz3uk79il2WMb496eIOVV3AqC9lCyu2NOAyl2Kt5KXlKRym7xa/o/2PD
 xiu2Mfaeo8Ba6WzbCEF3oEwEregO0lsE3HD0XF+hi5aQ5m0SJiW7/du+Avlqi0LMWXY4IjzNJ
 nHS9SBcH4DC2ZEDrZID5gKYxrzwJUj2KorwV75HE9LbBVjcBDvIbNaNtWVaGDV1sTfxNkB/Yv
 /1uJ4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 22 Apr 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Create another thread to watch over the daemon process and
> automatically shut it down if necessary.
>
> This commit creates the basic framework for a "health" thread
> to monitor the daemon and/or the file system.  Later commits
> will add platform-specific code to do the actual work.
>
> The "health" thread is intended to monitor conditions that
> would be difficult to track inside the IPC thread pool and/or
> the file system listener threads.  For example, when there are
> file system events outside of the watched worktree root or if
> we want to have an idle-timeout auto-shutdown feature.
>
> This commit creates the health thread itself, defines the thread-proc
> and sets up the thread's event loop.  It integrates this new thread
> into the existing IPC and Listener thread models.
>
> This commit defines the API to the platform-specific code where all of
> the monitoring will actually happen.
>
> The platform-specific code for MacOS is just stubs.  Meaning that the
> health thread will immediately exit on MacOS, but that is OK and
> expected.  Future work can define MacOS-specific monitoring.
>
> The platform-specific code for Windows sets up enough of the
> WaitForMultipleObjects() machinery to watch for system and/or custom
> events.  Currently, the set of wait handles only includes our custom
> shutdown event (sent from our other theads).  Later commits in this
> series will extend the set of wait handles to monitor other
> conditions.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Makefile                             |  6 ++-
>  builtin/fsmonitor--daemon.c          | 39 +++++++++++++++
>  compat/fsmonitor/fsm-health-darwin.c | 24 ++++++++++
>  compat/fsmonitor/fsm-health-win32.c  | 72 ++++++++++++++++++++++++++++
>  compat/fsmonitor/fsm-health.h        | 47 ++++++++++++++++++
>  contrib/buildsystems/CMakeLists.txt  |  2 +
>  fsmonitor--daemon.h                  |  4 ++
>  7 files changed, 192 insertions(+), 2 deletions(-)
>  create mode 100644 compat/fsmonitor/fsm-health-darwin.c
>  create mode 100644 compat/fsmonitor/fsm-health-win32.c
>  create mode 100644 compat/fsmonitor/fsm-health.h
>
> diff --git a/Makefile b/Makefile
> index 93604fe8ef7..5f1623baadd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -472,8 +472,9 @@ all::
>  #
>  # If your platform supports a built-in fsmonitor backend, set
>  # FSMONITOR_DAEMON_BACKEND to the "<name>" of the corresponding
> -# `compat/fsmonitor/fsm-listen-<name>.c` that implements the
> -# `fsm_listen__*()` routines.
> +# `compat/fsmonitor/fsm-listen-<name>.c` and
> +# `compat/fsmonitor/fsm-health-<name>.c` files
> +# that implement the `fsm_listen__*()` and `fsm_health__*()` routines.
>  #
>  # If your platform has OS-specific ways to tell if a repo is incompatib=
le with
>  # fsmonitor (whether the hook or IPC daemon version), set FSMONITOR_OS_=
SETTINGS
> @@ -1982,6 +1983,7 @@ endif
>  ifdef FSMONITOR_DAEMON_BACKEND
>  	COMPAT_CFLAGS +=3D -DHAVE_FSMONITOR_DAEMON_BACKEND
>  	COMPAT_OBJS +=3D compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEN=
D).o
> +	COMPAT_OBJS +=3D compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEN=
D).o
>  endif
>
>  ifdef FSMONITOR_OS_SETTINGS
> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index b2f578b239a..2c109cf8b37 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -3,6 +3,7 @@
>  #include "parse-options.h"
>  #include "fsmonitor.h"
>  #include "fsmonitor-ipc.h"
> +#include "compat/fsmonitor/fsm-health.h"
>  #include "compat/fsmonitor/fsm-listen.h"
>  #include "fsmonitor--daemon.h"
>  #include "simple-ipc.h"
> @@ -1136,6 +1137,18 @@ void fsmonitor_publish(struct fsmonitor_daemon_st=
ate *state,
>  	pthread_mutex_unlock(&state->main_lock);
>  }
>
> +static void *fsm_health__thread_proc(void *_state)
> +{
> +	struct fsmonitor_daemon_state *state =3D _state;
> +
> +	trace2_thread_start("fsm-health");
> +
> +	fsm_health__loop(state);
> +
> +	trace2_thread_exit();
> +	return NULL;
> +}
> +
>  static void *fsm_listen__thread_proc(void *_state)
>  {
>  	struct fsmonitor_daemon_state *state =3D _state;
> @@ -1174,6 +1187,7 @@ static int fsmonitor_run_daemon_1(struct fsmonitor=
_daemon_state *state)
>  		 */
>  		.uds_disallow_chdir =3D 0
>  	};
> +	int health_started =3D 0;
>  	int listener_started =3D 0;
>  	int err =3D 0;
>
> @@ -1201,6 +1215,17 @@ static int fsmonitor_run_daemon_1(struct fsmonito=
r_daemon_state *state)
>  	}
>  	listener_started =3D 1;
>
> +	/*
> +	 * Start the health thread to watch over our process.
> +	 */
> +	if (pthread_create(&state->health_thread, NULL,
> +			   fsm_health__thread_proc, state) < 0) {
> +		ipc_server_stop_async(state->ipc_server_data);
> +		err =3D error(_("could not start fsmonitor health thread"));
> +		goto cleanup;
> +	}
> +	health_started =3D 1;
> +
>  	/*
>  	 * The daemon is now fully functional in background threads.
>  	 * Our primary thread should now just wait while the threads
> @@ -1223,10 +1248,17 @@ cleanup:
>  		pthread_join(state->listener_thread, NULL);
>  	}
>
> +	if (health_started) {
> +		fsm_health__stop_async(state);
> +		pthread_join(state->health_thread, NULL);
> +	}
> +
>  	if (err)
>  		return err;
>  	if (state->listen_error_code)
>  		return state->listen_error_code;
> +	if (state->health_error_code)
> +		return state->health_error_code;
>  	return 0;
>  }
>
> @@ -1242,6 +1274,7 @@ static int fsmonitor_run_daemon(void)
>  	pthread_mutex_init(&state.main_lock, NULL);
>  	pthread_cond_init(&state.cookies_cond, NULL);
>  	state.listen_error_code =3D 0;
> +	state.health_error_code =3D 0;
>  	state.current_token_data =3D fsmonitor_new_token_data();
>
>  	/* Prepare to (recursively) watch the <worktree-root> directory. */
> @@ -1321,6 +1354,11 @@ static int fsmonitor_run_daemon(void)
>  		goto done;
>  	}
>
> +	if (fsm_health__ctor(&state)) {
> +		err =3D error(_("could not initialize health thread"));
> +		goto done;
> +	}
> +
>  	/*
>  	 * CD out of the worktree root directory.
>  	 *
> @@ -1344,6 +1382,7 @@ done:
>  	pthread_cond_destroy(&state.cookies_cond);
>  	pthread_mutex_destroy(&state.main_lock);
>  	fsm_listen__dtor(&state);
> +	fsm_health__dtor(&state);
>
>  	ipc_server_free(state.ipc_server_data);
>
> diff --git a/compat/fsmonitor/fsm-health-darwin.c b/compat/fsmonitor/fsm=
-health-darwin.c
> new file mode 100644
> index 00000000000..b9f709e8548
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-health-darwin.c
> @@ -0,0 +1,24 @@
> +#include "cache.h"
> +#include "config.h"
> +#include "fsmonitor.h"
> +#include "fsm-health.h"
> +#include "fsmonitor--daemon.h"
> +
> +int fsm_health__ctor(struct fsmonitor_daemon_state *state)
> +{
> +	return 0;
> +}
> +
> +void fsm_health__dtor(struct fsmonitor_daemon_state *state)
> +{
> +	return;
> +}
> +
> +void fsm_health__loop(struct fsmonitor_daemon_state *state)
> +{
> +	return;
> +}
> +
> +void fsm_health__stop_async(struct fsmonitor_daemon_state *state)
> +{
> +}
> diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-=
health-win32.c
> new file mode 100644
> index 00000000000..94b1d020f25
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-health-win32.c
> @@ -0,0 +1,72 @@
> +#include "cache.h"
> +#include "config.h"
> +#include "fsmonitor.h"
> +#include "fsm-health.h"
> +#include "fsmonitor--daemon.h"
> +
> +struct fsm_health_data
> +{
> +	HANDLE hEventShutdown;
> +
> +	HANDLE hHandles[1]; /* the array does not own these handles */
> +#define HEALTH_SHUTDOWN 0

How about defining `HANDLE hHandles[HEALTH_SHUTDOWN + 1]` to indicate that
the constant is used as an offset into `hHandles`?

> +	int nr_handles; /* number of active event handles */
> +};
> +
> +int fsm_health__ctor(struct fsmonitor_daemon_state *state)
> +{
> +	struct fsm_health_data *data;
> +
> +	CALLOC_ARRAY(data, 1);

I _guess_ that this is okay, even if `data` is not actually an array. But
it's a convenient construct to get the parameters right.

Thank you!
Dscho

> +
> +	data->hEventShutdown =3D CreateEvent(NULL, TRUE, FALSE, NULL);
> +
> +	data->hHandles[HEALTH_SHUTDOWN] =3D data->hEventShutdown;
> +	data->nr_handles++;
> +
> +	state->health_data =3D data;
> +	return 0;
> +}
> +
> +void fsm_health__dtor(struct fsmonitor_daemon_state *state)
> +{
> +	struct fsm_health_data *data;
> +
> +	if (!state || !state->health_data)
> +		return;
> +
> +	data =3D state->health_data;
> +
> +	CloseHandle(data->hEventShutdown);
> +
> +	FREE_AND_NULL(state->health_data);
> +}
> +
> +void fsm_health__loop(struct fsmonitor_daemon_state *state)
> +{
> +	struct fsm_health_data *data =3D state->health_data;
> +
> +	for (;;) {
> +		DWORD dwWait =3D WaitForMultipleObjects(data->nr_handles,
> +						      data->hHandles,
> +						      FALSE, INFINITE);
> +
> +		if (dwWait =3D=3D WAIT_OBJECT_0 + HEALTH_SHUTDOWN)
> +			goto clean_shutdown;
> +
> +		error(_("health thread wait failed [GLE %ld]"),
> +		      GetLastError());
> +		goto force_error_stop;
> +	}
> +
> +force_error_stop:
> +	state->health_error_code =3D -1;
> +	ipc_server_stop_async(state->ipc_server_data);
> +clean_shutdown:
> +	return;
> +}
> +
> +void fsm_health__stop_async(struct fsmonitor_daemon_state *state)
> +{
> +	SetEvent(state->health_data->hHandles[HEALTH_SHUTDOWN]);
> +}
> diff --git a/compat/fsmonitor/fsm-health.h b/compat/fsmonitor/fsm-health=
.h
> new file mode 100644
> index 00000000000..45547ba9380
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-health.h
> @@ -0,0 +1,47 @@
> +#ifndef FSM_HEALTH_H
> +#define FSM_HEALTH_H
> +
> +/* This needs to be implemented by each backend */
> +
> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
> +
> +struct fsmonitor_daemon_state;
> +
> +/*
> + * Initialize platform-specific data for the fsmonitor health thread.
> + * This will be called from the main thread PRIOR to staring the
> + * thread.
> + *
> + * Returns 0 if successful.
> + * Returns -1 otherwise.
> + */
> +int fsm_health__ctor(struct fsmonitor_daemon_state *state);
> +
> +/*
> + * Cleanup platform-specific data for the health thread.
> + * This will be called from the main thread AFTER joining the thread.
> + */
> +void fsm_health__dtor(struct fsmonitor_daemon_state *state);
> +
> +/*
> + * The main body of the platform-specific event loop to monitor the
> + * health of the daemon process.  This will run in the health thread.
> + *
> + * The health thread should call `ipc_server_stop_async()` if it needs
> + * to cause a shutdown.  (It should NOT do so if it receives a shutdown
> + * shutdown signal.)
> + *
> + * It should set `state->health_error_code` to -1 if the daemon should =
exit
> + * with an error.
> + */
> +void fsm_health__loop(struct fsmonitor_daemon_state *state);
> +
> +/*
> + * Gently request that the health thread shutdown.
> + * It does not wait for it to stop.  The caller should do a JOIN
> + * to wait for it.
> + */
> +void fsm_health__stop_async(struct fsmonitor_daemon_state *state);
> +
> +#endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
> +#endif /* FSM_HEALTH_H */
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/=
CMakeLists.txt
> index b8f9f7a0388..16ace43d1c7 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -289,12 +289,14 @@ if(SUPPORTS_SIMPLE_IPC)
>  	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
>  		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
>  		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
> +		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
>
>  		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
>  		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-win32.c)
>  	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
>  		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
>  		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
> +		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
>
>  		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
>  		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
> diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
> index 2c6fa1a5d91..2102a5c9ff5 100644
> --- a/fsmonitor--daemon.h
> +++ b/fsmonitor--daemon.h
> @@ -34,9 +34,11 @@ void fsmonitor_batch__free_list(struct fsmonitor_batc=
h *batch);
>  void fsmonitor_batch__add_path(struct fsmonitor_batch *batch, const cha=
r *path);
>
>  struct fsm_listen_data; /* opaque platform-specific data for listener t=
hread */
> +struct fsm_health_data; /* opaque platform-specific data for health thr=
ead */
>
>  struct fsmonitor_daemon_state {
>  	pthread_t listener_thread;
> +	pthread_t health_thread;
>  	pthread_mutex_t main_lock;
>
>  	struct strbuf path_worktree_watch;
> @@ -51,7 +53,9 @@ struct fsmonitor_daemon_state {
>  	struct hashmap cookies;
>
>  	int listen_error_code;
> +	int health_error_code;
>  	struct fsm_listen_data *listen_data;
> +	struct fsm_health_data *health_data;
>
>  	struct ipc_server_data *ipc_server_data;
>  	struct strbuf path_ipc;
> --
> gitgitgadget
>
>
